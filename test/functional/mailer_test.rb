require 'test_helper'

class MailerTest < ActionMailer::TestCase

  setup { ActionMailer::Base.deliveries.clear }

  context "upon successfull questionnaire application" do
    setup do
      @school = create(:school, name: "Example University")
      @questionnaire = create(:questionnaire,
        first_name: "Joe",
        last_name: "Smith",
        city: "Anytown",
        state: "NY",
        school_id: @school.id,
        year: "1",
        interest: "Development",
        experience: "first",
        shirt_size: "L",
        dietary_medical_notes: "Peanut allergy"
      )
      @user = create(:user, questionnaire: @questionnaire, email: "joe.smith@example.com")
    end

    should "deliver email to questionnaire" do
      email = Mailer.application_confirmation_email(@questionnaire).deliver

      assert_equal [@questionnaire.email],                email.to
      assert_equal "[BrickHack] Application Received",  email.subject

      assert_match "Joe Smith",                         email.encoded
      assert_match "joe.smith@example.com",             email.encoded
      assert_match @questionnaire.birthday_formatted,   email.encoded
      assert_match "Anytown, NY",                       email.encoded
      assert_match "Example University",                email.encoded
      assert_match "1st Year",                          email.encoded
      assert_match "This is my 1st hackathon!",         email.encoded
      assert_match "Development",                       email.encoded
      assert_match "L",                                 email.encoded
      assert_match "Not provided",                      email.encoded
      assert_match "Peanut allergy",                    email.encoded
    end
  end

  context "upon trigger of a bulk message" do
    setup do
      @message = create(:message, subject: "Example Subject", body: "Hello World!")
      @user = create(:user, email: "test@example.com")
    end

    should "deliver bulk messages" do
      email = Mailer.bulk_message_email(@message, @user.id).deliver

      assert_equal ["test@example.com"],                email.to
      assert_equal "[BrickHack] Example Subject",       email.subject
      assert_match /Hello World/,                       email.encoded
    end
  end

end
