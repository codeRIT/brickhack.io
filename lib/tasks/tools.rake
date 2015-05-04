namespace :tools do
  desc "Prints a list of accepted & confirmed attendees from a specific school in CSV format"
  task :bus_list, [:school_name] => :environment do |t, args|
    school_name = args[:school_name]
    if school_name.blank?
      puts "Usage: rake tools:bus_list[\"school_name\"]"
      return
    end
    school_id = School.where(name: school_name).first.id
    a = Questionnaire.where("school_id = :school_id AND acc_status = \"rsvp_confirmed\" OR school_id = :school_id AND acc_status = \"accepted\"", school_id: school_id).map { |q| q.first_name + "," + q.last_name + "," + q.email + "," + Questionnaire::POSSIBLE_ACC_STATUS[q.acc_status] }
    puts "First Name,Last Name,Email,Status\n"
    puts a.join("\n")
  end

  desc "Prints the list of attendees with dietary/medical notes in CSV format"
  task :dietary_notes => :environment do
    puts "First Name,Last Name,Email,Dietary/Medical Notes\n"
    puts Questionnaire.where("acc_status = \"rsvp_confirmed\" AND dietary_medical_notes != \"\" AND dietary_medical_notes != \"none\" AND dietary_medical_notes != \"None\" AND dietary_medical_notes != \"N/A\" AND dietary_medical_notes != \"NONE\"").map { |q| "#{q.first_name},#{q.last_name},#{q.email},\"#{q.dietary_medical_notes}\"" }.join("\n")
  end

  desc "Merges one school's attendees with another"
  task :merge_schools, [:old_school_name, :new_school_name] => :environment do |t, args|
    old_school_name = args[:old_school_name]
    new_school_name = args[:new_school_name]
    if old_school_name.blank? || new_school_name.blank?
      puts "Usage: rake tools:merge_schools[\"Old school name\",\"New school name\"]"
      return
    end

    old_school = School.where(name: old_school_name).first
    if old_school.blank?
      puts "School doesn't exist: #{old_school_name}"
      return
    end
    new_school = School.where(name: new_school_name).first
    if new_school.blank?
      puts "School doesn't exist: #{new_school_name}"
      return
    end

    Questionnaire.where(school_id: old_school.id).each { |q| puts "Updating #{q.full_name} (ID: #{q.id})...\n"; q.update_attribute(:school_id, new_school.id) }

    old_school.reload

    if old_school.questionnaire_count < 1
      puts "\nDeleting school #{old_school.name}...\n"
      old_school.destroy
    else
      puts "\n*** Old school NOT deleted: #{old_school.questionnaire_count} questionnaires still associated!\n"
    end

    puts "\nDone\n"
  end

  desc "Copies signed-in attendees' resumes to new folder"
  task :copy_resumes, [:new_folder_id] => :environment do |t, args|

    if args[:new_folder_id].blank?
      puts "Usage: rake tools:copy_resumes[\"New folder id\"]"
      return
    end

    @google_drive_credentials = parse_credentials(
      client_id:     ENV["GOOGLE_DRIVE_CLIENT_ID"],
      client_secret: ENV["GOOGLE_DRIVE_CLIENT_SECRET"],
      access_token:  ENV["GOOGLE_DRIVE_ACCESS_TOKEN"],
      refresh_token: ENV["GOOGLE_DRIVE_REFRESH_TOKEN"]
    )

    Questionnaire.where("resume_file_name IS NOT NULL AND can_share_resume = '1' AND checked_in_at IS NOT NULL").each do |q|
      file_name = "#{q.id}_#{q.resume_file_name}"
      puts "Copying \"#{file_name}\"..."
      file_id = search_for_title(file_name)
      if file_id.nil?
        puts "Error: File not found"
        next
      end
      new_file_name = "#{q.id} #{q.full_name}.pdf"
      puts "Success" if copy_file_to_folder(google_api_client, file_id, args[:new_folder_id], new_file_name)
    end
  end

  private

  def copy_file_to_folder(client, file_id, new_folder_id, new_file_name)
    drive = client.discovered_api('drive', 'v2')
    new_file_body = {
      title: new_file_name,
      parents: [
        {
          id: new_folder_id
        }
      ]
    }
    begin
      result = client.execute(
        api_method:  drive.files.copy,
        body_object: new_file_body,
        parameters:  { fileId: file_id }
      )
      if result.status == 200
        return result.data
      else
        puts "Error: #{file_id} could not be moved: #{result.data['error']['message']}"
        if result.data['error']['message'] == "User rate limit exceeded"
          raise "Rate Limit Exceeded"
        end
      end
    rescue => e
      if e.message == "Rate Limit Exceeded"
        puts "Sleeping..."
        sleep 5
        retry
      end
    end
  end

  # Copied from storage/google_drive.rb /w modifications

  def search_for_title(title)
    parameters = {
            folderId: ENV["GOOGLE_DRIVE_PUBLIC_FOLDER_ID"],
            q:        "title = '#{title}'",
            fields:   "items/id"
    }
    client = google_api_client
    drive  = client.discovered_api('drive', 'v2')
    result = client.execute(api_method: drive.children.list, parameters: parameters)
    if result.status == 200 && result.data.items.length > 0
      result.data.items[0]['id']
    end
  end

  def parse_credentials(credentials)
    credentials.symbolize_keys
  end

  # Copied from storage/google_drive.rb, no modifications

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

  def assert_required_keys
    keys_list = [:client_id, :client_secret, :access_token, :refresh_token]
    keys_list.each do |key|
      @google_drive_credentials.fetch(key)
    end
  end
end
