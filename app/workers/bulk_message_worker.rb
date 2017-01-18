class BulkMessageWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    return unless message.present? && message.status == "queued"
    message.update_attribute(:started_at, Time.now)

    recipients = build_recipients(message.recipients)

    recipients.each do |recipient|
      Mailer.delay.bulk_message_email(message.id, recipient)
    end

    message.update_attribute(:delivered_at, Time.now)
  end

  private

  def build_recipients(recipient_types)
    recipients = Set.new
    recipient_types.each do |type|
      recipients += recipients_query(type)
    end
    recipients
  end

  def recipients_query(type)
    case type
    when "all"
      User.where(admin: false).pluck(:id)
    when "incomplete"
      User.where(admin: false).pluck(:id) - Questionnaire.pluck(:user_id)
    when "complete"
      Questionnaire.pluck(:user_id)
    when "accepted"
      Questionnaire.where(acc_status: "accepted").pluck(:user_id)
    when "denied"
      Questionnaire.where(acc_status: "denied").pluck(:user_id)
    when "waitlisted"
      Questionnaire.where(acc_status: "waitlist").pluck(:user_id)
    when "late-waitlisted"
      Questionnaire.where(acc_status: "late_waitlist").pluck(:user_id)
    when "rsvp-confirmed"
      Questionnaire.where(acc_status: "rsvp_confirmed").pluck(:user_id)
    when "rsvp-denied"
      Questionnaire.where(acc_status: "rsvp_denied").pluck(:user_id)
    when "checked-in"
      Questionnaire.where("checked_in_at IS NOT NULL").pluck(:user_id)
    when "non-checked-in"
      Questionnaire.where("(acc_status = 'accepted' OR acc_status = 'accepted' OR acc_status = 'rsvp_denied') AND checked_in_at IS NULL").pluck(:user_id)
    when "bus-list-cornell-bing"
      BusList.find(1).passengers.pluck(:user_id)
    when "bus-list-buffalo"
      BusList.find(2).passengers.pluck(:user_id)
    when "bus-list-albany"
      BusList.find(3).passengers.pluck(:user_id)
    when "bus-list-cornell-bing-eligible"
      Questionnaire.joins(:school).where("(schools.bus_list_id = 1 AND riding_bus != 1) AND (acc_status = 'accepted' OR acc_status = 'rsvp_confirmed')").pluck(:user_id)
    when "bus-list-buffalo-eligible"
      Questionnaire.joins(:school).where("(schools.bus_list_id = 2 AND riding_bus != 1) AND (acc_status = 'accepted' OR acc_status = 'rsvp_confirmed')").pluck(:user_id)
    when "bus-list-albany-eligible"
      Questionnaire.joins(:school).where("(schools.bus_list_id = 3 AND riding_bus != 1) AND (acc_status = 'accepted' OR acc_status = 'rsvp_confirmed')").pluck(:user_id)
    when "bus-list-cornell-bing-applied"
      Questionnaire.joins(:school).where("(schools.bus_list_id = 1) AND (acc_status != 'accepted' AND acc_status != 'rsvp_confirmed' AND acc_status != 'rsvp_denied')").pluck(:user_id)
    when "bus-list-buffalo-applied"
      Questionnaire.joins(:school).where("(schools.bus_list_id = 2) AND (acc_status != 'accepted' AND acc_status != 'rsvp_confirmed' AND acc_status != 'rsvp_denied')").pluck(:user_id)
    when "bus-list-albany-applied"
      Questionnaire.joins(:school).where("(schools.bus_list_id = 3) AND (acc_status != 'accepted' AND acc_status != 'rsvp_confirmed' AND acc_status != 'rsvp_denied')").pluck(:user_id)
    when "school-rit"
      Questionnaire.where("school_id = 2304 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").pluck(:user_id)
    when "school-cornell"
      Questionnaire.where("school_id = 2164 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").pluck(:user_id)
    when "school-binghamton"
      Questionnaire.where("school_id = 5526 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").pluck(:user_id)
    when "school-buffalo"
      Questionnaire.where("school_id = 2345 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").pluck(:user_id)
    when "school-waterloo"
      Questionnaire.where("school_id = 5580 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").pluck(:user_id)
    when "school-toronto"
      Questionnaire.where("school_id = 5539 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").pluck(:user_id)
    when "school-umd-collegepark"
      Questionnaire.where("school_id = 5543 AND (acc_status = \"rsvp_confirmed\" OR acc_status = \"accepted\")").pluck(:user_id)
    end
  end
end
