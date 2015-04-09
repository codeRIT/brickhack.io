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

  desc "Merges one school's attendees with another"
  task :merge_school, [:old_school_name, :new_school_name] => :environment do |t, args|
    old_school_name = args[:old_school_name]
    new_school_name = args[:new_school_name]
    if old_school_name.blank? || new_school_name.blank?
      puts "Usage: rake tools:merge_school[\"Old school name\",\"New school name\"]"
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

end
