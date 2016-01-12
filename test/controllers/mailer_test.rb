require 'test_helper'

class MailerTest < ActionMailer::TestCase

  setup { ActionMailer::Base.deliveries.clear }

  context "upon successfull questionnaire application" do
    setup do
      @school = create(:school, name: "Example University")
      @questionnaire = create(:questionnaire,
        first_name: "Joe",
        last_name: "Smith",
        email: "joe.smith@example.com",
        school_id: @school.id
      )
      @user = create(:user, questionnaire: @questionnaire, email: "joe.smith@example.com")
    end

    should "deliver email to questionnaire" do
      email = Mailer.application_confirmation_email(@questionnaire.id).deliver_now

      assert_equal [@questionnaire.email],                email.to
      assert_equal "[BrickHack] Application Received",  email.subject

      assert_match "Joe Smith",                         email.encoded
      assert_match "joe.smith@example.com",             email.encoded
    end
  end

  context "upon successfull rsvp confirmation" do
    setup do
      @school = create(:school, name: "Example University")
      @questionnaire = create(:questionnaire)
      @user = create(:user, questionnaire: @questionnaire, email: "joe.smith@example.com")
    end

    should "deliver email to questionnaire" do
      email = Mailer.rsvp_confirmation_email(@questionnaire.id).deliver_now

      assert_equal [@questionnaire.email],              email.to
      assert_equal "[BrickHack] RSVP Confirmation",     email.subject

      assert_match "You are confirmed",                 email.encoded
    end
  end

  context "upon application denial" do
    setup do
      @school = create(:school, name: "Example University")
      @questionnaire = create(:questionnaire)
      @user = create(:user, questionnaire: @questionnaire, email: "joe.smith@example.com")
    end

    should "deliver email to questionnaire" do
      email = Mailer.denied_email(@questionnaire.id).deliver_now

      assert_equal [@questionnaire.email],              email.to
      assert_equal "[BrickHack] Your application status", email.subject

      assert_match "Dear ",                             email.encoded
    end
  end

  context "upon application acceptance" do
    setup do
      @school = create(:school, name: "Example University")
      @questionnaire = create(:questionnaire)
      @user = create(:user, questionnaire: @questionnaire, email: "joe.smith@example.com")
    end

    should "deliver email to questionnaire" do
      email = Mailer.accepted_email(@questionnaire.id).deliver_now

      assert_equal [@questionnaire.email],              email.to
      assert_equal "[BrickHack] You've been accepted!", email.subject

      assert_match "Congratulations ",                  email.encoded
    end
  end

  context "upon trigger of a bulk message" do
    setup do
      @message = create(:message, subject: "Example Subject", body: "Hello World!")
      @user = create(:user, email: "test@example.com")
    end

    should "deliver bulk messages" do
      email = Mailer.bulk_message_email(@message.id, @user.id).deliver_now

      assert_equal ["test@example.com"],                email.to
      assert_equal "[BrickHack] Example Subject",       email.subject
      assert_match /Hello World/,                       email.encoded
    end
  end

end
