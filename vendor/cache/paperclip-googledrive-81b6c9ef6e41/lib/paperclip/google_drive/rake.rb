
require 'google/api_client'

module Paperclip
  module GoogleDrive
    module Rake
      extend self

      def authorize
        puts 'Enter client ID:'
        client_id = $stdin.gets.chomp
        puts 'Enter client SECRET:'
        client_secret = $stdin.gets.chomp.strip
#        puts 'Enter SCOPE:'
#        oauth_scope = $stdin.gets.chomp.strip
        oauth_scope = ['https://www.googleapis.com/auth/drive', 'https://www.googleapis.com/auth/userinfo.profile']
        puts 'Enter redirect URI:'
        redirect_uri = $stdin.gets.chomp.strip

        # Create a new API client & load the Google Drive API
        client = Google::APIClient.new(:application_name => 'ppc-gd', :application_version => PaperclipGoogleDrive::VERSION)
        drive = client.discovered_api('drive', 'v2')

        client.authorization.client_id = client_id
        client.authorization.client_secret = client_secret
        client.authorization.scope = oauth_scope
        client.authorization.redirect_uri = redirect_uri

        # Request authorization
        uri = client.authorization.authorization_uri.to_s
        puts "\nGo to this url:"
        puts client.authorization.authorization_uri.to_s
        puts "\n Accept the authorization request from Google in your browser"

        puts "\n\n\n Google will redirect you to localhost, but just copy the code parameter out of the URL they redirect you to, paste it here and hit enter:\n"

        code = $stdin.gets.chomp.strip
        client.authorization.code = code
        client.authorization.fetch_access_token!

        puts "\nAuthorization completed.\n\n"
        puts "client = Google::APIClient.new"
        puts "client.authorization.client_id = '#{client_id}'"
        puts "client.authorization.client_secret = '#{client_secret}'"
        puts "client.authorization.access_token = '#{client.authorization.access_token}'"
        puts "client.authorization.refresh_token = '#{client.authorization.refresh_token}'"
        puts "\n"
      end
    end
  end
end