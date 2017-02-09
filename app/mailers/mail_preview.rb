if defined?(ActionMailer::Preview)
  class MailPreview < ActionMailer::Preview
    def application_confirmation_email
      questionnaire = Questionnaire.first
      Mailer.application_confirmation_email(questionnaire)
    end

    def rsvp_confirmation_email
      Mailer.rsvp_confirmation_email(Questionnaire.first.id)
    end

    def accepted_email
      Mailer.accepted_email(Questionnaire.first.id)
    end

    def denied_email
      Mailer.denied_email(Questionnaire.first.id)
    end

    def bulk_message_email
      message = Message.first
      Mailer.bulk_message_email(message, User.first.id)
    end

    def incomplete_reminder_email
      Mailer.incomplete_reminder_email(User.without_questionnaire.first.id)
    end

    def bus_captain_confirmation_email
      buslist = BusList.first
      Mailer.bus_captain_confirmation_email(buslist.id, buslist.captains.first.id)
    end

    def slack_invite_email
      Mailer.slack_invite_email(Questionnaire.first.id)
    end

    def bus_list_update_email
      Mailer.bus_list_update_email(BusList.first.passengers.first.id)
    end
  end
end
