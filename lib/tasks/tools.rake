require 'zip'

namespace :tools do
  desc "Prints a list of accepted & confirmed attendees from a specific school in CSV format"
  task :bus_list, [:school_name] => :environment do |_t, args|
    school_name = args[:school_name]
    abort("Usage: rake tools:bus_list[\"school_name\"]") if school_name.blank?
    school_id = School.where(name: school_name).first.id
    a = Questionnaire.where("school_id = :school_id AND acc_status = \"rsvp_confirmed\" OR school_id = :school_id AND acc_status = \"accepted\"", school_id: school_id).map { |q| q.first_name + "," + q.last_name + "," + q.email + "," + Questionnaire::POSSIBLE_ACC_STATUS[q.acc_status] }
    puts "First Name,Last Name,Email,Status\n"
    puts a.join("\n")
  end

  desc "Removes all users/questionnaires and resets school questionnaire counts"
  task :reset_questionnaires, [] => :environment do |_t, _args|
    puts "Deleting all questionnaires..."
    Questionnaire.delete_all
    puts "Deleting all users..."
    User.delete_all
    puts "Resetting all school questionnaire counts..."
    School.where("questionnaire_count > 0").update_all questionnaire_count: 0
  end

  desc "Invite all RSVP confirmed users to Slack"
  task :invite_all_confirmed_to_slack, [] => :environment do |_t, _args|
    puts "Queueing invitations..."
    Questionnaire.where(acc_status: 'rsvp_confirmed').each(&:invite_to_slack)
    puts "Done."
  end

  desc "Create a .zip of resumes and upload to S3"
  task :bundle_resumes, [:attendee_type] => :environment do |_t, args|
    attendee_type = args[:attendee_type]
    valid_options = ['rsvp_confirmed', 'checked_in']
    case attendee_type
    when 'rsvp_confirmed'
      questionnaires = Questionnaire.where(acc_status: 'rsvp_confirmed')
    when 'checked_in'
      questionnaires = Questionnaire.where('checked_in_at > 0')
    else
      abort "Invalid :attendee_type argument: '#{attendee_type}'. Must be one of: " + valid_options.map { |type| "'#{type}'"}.join(', ')
    end

    Dir.mktmpdir('resume-bundle') do |dir|
      Dir.mkdir(File.join(dir, "resumes"))
      zipfile_name = Date.today.strftime('%Y-%m-%d') + '-resumes.zip'
      zipfile_path = File.join(dir, zipfile_name)

      # Download all of the resumes
      resume_paths = []
      questionnaires.each do |q|
        next unless q.can_share_info? && q.resume.exists?
        puts "--> Downloading #{q.id} resume, filename '#{q.resume.original_filename}'"
        download = open(q.resume.expiring_url)
        filename = "#{q.id}-#{q.resume.original_filename}"
        path = File.join(dir, "resumes", filename)
        IO.copy_stream(download, path)
        resume_paths << { path: path, filename: filename }
      end

      # Zip up all of the files
      Zip::File.open(zipfile_path, Zip::File::CREATE) do |zipfile|
        resume_paths.each do |resume|
          path = resume[:path]
          filename = resume[:filename]
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          zipfile.add(filename, path)
        end
      end

      # Upload the zip to S3
      s3 = Aws::S3::Resource.new
      bucket = ENV['AWS_BUCKET']
      obj = s3.bucket(bucket).object(zipfile_name)
      obj.upload_file(zipfile_path)

      # Generate a temporary link
      signer = Aws::S3::Presigner.new
      url = signer.presigned_url(:get_object, bucket: bucket, key: zipfile_name)

      puts "Finished! Temporary download URL (will expire shortly):"
      puts url
    end
  end
end
