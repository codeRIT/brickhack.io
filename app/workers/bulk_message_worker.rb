class BulkMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    return unless message.present? && message.status == "queued"
    message.update_attribute(:started_at, Time.now)

    recipients = Set.new
    message.recipients.each do |recipient_type|
      case recipient_type
      when "all"
        recipients += User.where(admin: false).select(:id).map(&:id)
      when "incomplete"
        recipients += User.where(admin: false).select(:id).map(&:id) - Questionnaire.select(:user_id).map(&:user_id)
      when "complete"
        recipients += Questionnaire.select(:user_id).map(&:user_id)
      when "accepted"
        recipients += Questionnaire.where(acc_status: "accepted").select(:user_id).map(&:user_id)
      when "denied"
        recipients += Questionnaire.where(acc_status: "denied").select(:user_id).map(&:user_id)
      when "waitlisted"
        recipients += Questionnaire.where(acc_status: "waitlist").select(:user_id).map(&:user_id)
      when "late-waitlisted"
        recipients += Questionnaire.where(acc_status: "late_waitlist").select(:user_id).map(&:user_id)
      when "rsvp-confirmed"
        recipients += Questionnaire.where(acc_status: "rsvp_confirmed").select(:user_id).map(&:user_id)
      when "rsvp-denied"
        recipients += Questionnaire.where(acc_status: "rsvp_denied").select(:user_id).map(&:user_id)
      when "checked-in"
        recipients += Questionnaire.where("checked_in_at != 0").select(:user_id).map(&:user_id)
      when "bus-list-cornell-bing"
        recipients += BusList.find(1).passengers.map(&:user_id)
      when "bus-list-buffalo"
        recipients += BusList.find(3).passengers.map(&:user_id)
      when "bus-list-rutgers-albany"
        recipients += BusList.find(5).passengers.map(&:user_id)
      when "bus-list-cornell-bing-eligible"
        recipients += Questionnaire.joins(:school).where("(schools.bus_list_id = 1 AND riding_bus != 1) AND (acc_status = 'accepted' OR acc_status = 'rsvp_confirmed')").select(:user_id).map(&:user_id)
      when "bus-list-buffalo-eligible"
        recipients += Questionnaire.joins(:school).where("(schools.bus_list_id = 3 AND riding_bus != 1) AND (acc_status = 'accepted' OR acc_status = 'rsvp_confirmed')").select(:user_id).map(&:user_id)
      when "bus-list-rutgers-albany-eligible"
        recipients += Questionnaire.joins(:school).where("(schools.bus_list_id = 5 AND riding_bus != 1) AND (acc_status = 'accepted' OR acc_status = 'rsvp_confirmed')").select(:user_id).map(&:user_id)
      when "school-rit"
        recipients += Questionnaire.where("school_id = 2304 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").select(:user_id).map(&:user_id)
      when "school-cornell"
        recipients += Questionnaire.where("school_id = 2164 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").select(:user_id).map(&:user_id)
      when "school-binghamton"
        recipients += Questionnaire.where("school_id = 5550 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").select(:user_id).map(&:user_id)
      when "school-buffalo"
        recipients += Questionnaire.where("school_id = 2345 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").select(:user_id).map(&:user_id)
      when "school-waterloo"
        recipients += Questionnaire.where("school_id = 5529 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").select(:user_id).map(&:user_id)
      when "school-toronto"
        recipients += Questionnaire.where("school_id = 5522 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").select(:user_id).map(&:user_id)
      when "school-umd-collegepark"
        recipients += Questionnaire.where("school_id = 5616 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").select(:user_id).map(&:user_id)
      end
    end

    recipients.each do |recipient|
      Mailer.delay.bulk_message_email(message.id, recipient)
    end

    message.update_attribute(:delivered_at, Time.now)
  end
end
