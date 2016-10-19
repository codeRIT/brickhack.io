
require 'active_support/core_ext/hash/keys'
require 'active_support/inflector/methods'
require 'active_support/core_ext/object/blank'
require 'yaml'
require 'erb'
require 'google/api_client'

module Paperclip

  module Storage
      # * self.extended(base) add instance variable to attachment on call
      # * url return url to show on site with style options
      # * path(style) return title that used to insert file to store or find it in store
      # * public_url_for title  return url to file if find by title or url to default image if set
      # * search_for_title(title) take title, search in given folder and if it finds a file, return id of a file or nil
      # * metadata_by_id(file_i get file metadata from store, used to back url or find out value of trashed
      # * exists?(style)  check either exists file with title or not
      # * default_image  return url to default url if set in option
      # * find_public_folder return id of Public folder, must be in options
      # return id of Public folder, must be in options
      # * file_tit return base pattern of title or custom one set by user
      # * parse_credentials(credenti get credentials from file, hash or path
      # * assert_required_keys  check either all ccredentials keys is set
      # * original_extension  return extension of file

    module GoogleDrive

      def self.extended(base)
        begin
          require 'google-api-client'
        rescue LoadError => e
          e.message << " (You may need to install the google-api-client gem)"
          raise e
        end unless defined?(Google)

        base.instance_eval do
          @google_drive_credentials = parse_credentials(@options[:google_drive_credentials] || {})
          @google_drive_options = @options[:google_drive_options] || {}
          google_api_client # Force validations of credentials
        end
      end
      #
      def flush_writes
        @queued_for_write.each do |style, file|
          if exists?(path(style))
            raise FileExists, "file \"#{path(style)}\" already exists in your Google Drive"
          else
            #upload(style, file) #style file
            client = google_api_client
            drive = client.discovered_api('drive', 'v2')
            result = client.execute(
              :api_method => drive.files.get,
              :parameters => { 'fileId' => @google_drive_options[:public_folder_id],
                              'fields' => '  id, title' })
            client.authorization.access_token = result.request.authorization.access_token
            client.authorization.refresh_token = result.request.authorization.refresh_token
            title, mime_type = title_for_file(style), "#{content_type}"
            parent_id = @google_drive_options[:public_folder_id] # folder_id for Public folder
            metadata = drive.files.insert.request_schema.new({
              'title' => title, #if it is no extension, that is a folder and another folder
              'description' => 'paperclip file on google drive',
              'mimeType' => mime_type })
            if parent_id
              metadata.parents = [{'id' => parent_id}]
            end
            media = Google::APIClient::UploadIO.new( file, mime_type)
            result = client.execute(
              :api_method => drive.files.insert,
              :body_object => metadata,
              :media => media,
              :parameters => {
                'uploadType' => 'multipart',
                'alt' => 'json' })
          end
        end
        after_flush_writes
        @queued_for_write = {}
      end
      #
      def flush_deletes
        @queued_for_delete.each do |path|
          Paperclip.log("delete #{path}")
          client = google_api_client
          drive = client.discovered_api('drive', 'v2')
          file_id = search_for_title(path)
          unless file_id.nil?
            folder_id = find_public_folder
            parameters = {'fileId' => file_id,
                          'folder_id' => folder_id }
            result = client.execute(
              :api_method => drive.files.delete,
              :parameters => parameters)
            if result.status != 204
              puts "An error occurred: #{result.data['error']['message']}"
            end
          end
        end
        @queued_for_delete = []
      end
      #
      def google_api_client
        @google_api_client ||= begin
          assert_required_keys
        # Initialize the client & Google+ API
          client = Google::APIClient.new(:application_name => 'ppc-gd', :application_version => PaperclipGoogleDrive::VERSION)
#          client = Google::APIClient.new(:application_name => @google_drive_credentials[:application_name], :application_version => @google_drive_credentials[:application_version])
          client.authorization.client_id = @google_drive_credentials[:client_id]
          client.authorization.client_secret = @google_drive_credentials[:client_secret]
          client.authorization.access_token = @google_drive_credentials[:access_token]
          client.authorization.refresh_token = @google_drive_credentials[:refresh_token]
          client
        end
      end
      #
      def google_drive
        client = google_api_client
        drive = client.discovered_api('drive', 'v2')
        drive
      end

      def url(*args)
        if present?
          style = args.first.is_a?(Symbol) ? args.first : default_style
          options = args.last.is_a?(Hash) ? args.last : {}
          public_url_for(path(style))
        else
          default_image
        end
      end

      def path(style)
        title_for_file(style)
      end

      def title_for_file(style)
        file_name = instance.instance_exec(style, &file_title)
        style_suffix = (style != default_style ? "_#{style}" : "")
        if original_extension.present? && file_name =~ /#{original_extension}$/
          file_name.sub(original_extension, "#{style_suffix}#{original_extension}")
        else
          file_name + style_suffix + original_extension.to_s
        end
      end # full title

      def public_url_for(title)
        searched_id = search_for_title(title) #return id if any or style
        if searched_id.nil? # it finds some file
          default_image
        else
          metadata = metadata_by_id(searched_id)
          metadata['webContentLink']
        end
      end # url
      # take title, search in given folder and if it finds a file, return id of a file or nil
      def search_for_title(title)
        parameters = {
                'folderId' => find_public_folder,
                'q' => "title = '#{title}'", # full_title
                'fields' => 'items/id'}
        client = google_api_client
        drive = client.discovered_api('drive', 'v2')
        result = client.execute(:api_method => drive.children.list,
                          :parameters => parameters)
        if result.status == 200
          if result.data.items.length > 0
            result.data.items[0]['id']
          elsif result.data.items.length == 0
            nil
          else
            nil
          end
        end
      end # id or nil

      def metadata_by_id(file_id)
        if file_id.is_a? String
          client = google_api_client
          drive = client.discovered_api('drive', 'v2')
          result = client.execute(
            :api_method => drive.files.get,
            :parameters => {'fileId' => file_id,
                            'fields' => 'title, id, webContentLink, labels/trashed' })
          if result.status == 200
            result.data # data.class # => Hash
          end
        end
      end

      def exists?(style = default_style)
        return false if not present?
        result_id = search_for_title(path(style))
        if result_id.nil?
          false
        else
          data_hash = metadata_by_id(result_id)
          !data_hash['labels']['trashed'] # if trashed -> not exists
        end
      end

      def default_image
        if @google_drive_options[:default_url] #if default image is set
          title = @google_drive_options[:default_url]
          searched_id = search_for_title(title) # id
          metadata = metadata_by_id(searched_id) unless searched_id.nil?
          metadata['webContentLink']
        else
          'No picture' # ---- ?
        end
      end

      def find_public_folder
        unless @google_drive_options[:public_folder_id]
          raise KeyError, "you must set a Public folder if into options"
        end
        @google_drive_options[:public_folder_id]
      end
      class FileExists < ArgumentError
      end
      private

        def file_title
          return @google_drive_options[:path] if @google_drive_options[:path] #path: proc
          eval %(proc { |style| "\#{id}_\#{#{name}.original_filename}"})
        end

        def parse_credentials(credentials)
          result =
            case credentials
            when File
              YAML.load(ERB.new(File.read(credentials.path)).result)
            when String, Pathname
              YAML.load(ERB.new(File.read(credentials)).result)
            when Hash
              credentials
            else
              raise ArgumentError, ":google_drive_credentials are not a path, file, nor a hash"
            end
          result.symbolize_keys #or string keys
        end
        # check either all ccredentials keys is set
        def assert_required_keys
          keys_list = [:client_id, :client_secret, :access_token, :refresh_token]
          keys_list.each do |key|
            @google_drive_credentials.fetch(key)
          end
        end
        # return extension of file
        def original_extension
          File.extname(original_filename)
        end
    end

  end

end
