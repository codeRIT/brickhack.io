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
      when "bus-list-cornell"
        recipients += BusList.find(1).passengers.map(&:user_id)
      when "bus-list-binghamtom"
        recipients += BusList.find(2).passengers.map(&:user_id)
      when "bus-list-buffalo"
        recipients += BusList.find(3).passengers.map(&:user_id)
      when "school-cornell"
        recipients += Questionnaire.where(acc_status: "rsvp_confirmed", school_id: 2164).select(:user_id).map(&:user_id)
      when "school-binghamton"
        recipients += Questionnaire.where(acc_status: "rsvp_confirmed", school_id: 5550).select(:user_id).map(&:user_id)
      when "school-buffalo"
        recipients += Questionnaire.where(acc_status: "rsvp_confirmed", school_id: 2345).select(:user_id).map(&:user_id)
      when "school-waterloo"
        recipients += Questionnaire.where(acc_status: "rsvp_confirmed", school_id: 5529).select(:user_id).map(&:user_id)
      when "school-toronto"
        recipients += Questionnaire.where(acc_status: "rsvp_confirmed", school_id: 5522).select(:user_id).map(&:user_id)
      end
    end

    recipients.each do |recipient|
      Mailer.delay.bulk_message_email(message.id, recipient)
    end

    message.update_attribute(:delivered_at, Time.now)
  end
end
