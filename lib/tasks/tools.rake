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

  desc "Invite all accepted users to Slack"
  task :invite_all_accepted_to_slack, [] => :environment do |_t, _args|
    puts "Queueing invitations..."
    Questionnaire.where("acc_status = 'accepted' OR acc_status = 'rsvp_confirmed'").each(&:invite_to_slack)
    puts "Done."
  end
end
