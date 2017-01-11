require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should strip_attribute :name
  should strip_attribute :subject
  should strip_attribute :template
  should strip_attribute :body

  should validate_presence_of :name
  should validate_presence_of :subject
  should validate_presence_of :recipients
  should validate_presence_of :template
  should validate_presence_of :body

  should allow_value("default").for(:template)
  should_not allow_value("foo").for(:template)

  context "delivered?" do
    should "return false if delivered date is not set" do
      message = build(:message)
      assert_equal false, message.delivered?
    end

    should "return true if delivered date is set" do
      message = build(:message, queued_at: 1.hour.ago, delivered_at: 1.hour.ago)
      assert_equal true, message.delivered?
    end
  end

  context "started?" do
    should "return false if started date is not set" do
      message = build(:message)
      assert_equal false, message.started?
    end

    should "return true if started date is set" do
      message = build(:message, started_at: 1.hour.ago)
      assert_equal true, message.started?
    end
  end

  context "queued?" do
    should "return false if queued date is not set" do
      message = build(:message)
      assert_equal false, message.queued?
    end

    should "return true if queued date is set" do
      message = build(:message, queued_at: 1.hour.ago)
      assert_equal true, message.queued?
    end
  end

  context "status" do
    should "return drafted if not queued or delivered" do
      message = build(:message)
      assert_equal "drafted", message.status
    end

    should "return queued if not queued or delivered" do
      message = build(:message, queued_at: 1.hour.ago)
      assert_equal "queued", message.status
    end

    should "return started if started but not delivered" do
      message = build(:message, queued_at: 1.hour.ago, started_at: 1.hour.ago)
      assert_equal "started", message.status
    end

    should "return delivered if not queued or delivered" do
      message = build(:message, queued_at: 1.hour.ago, started_at: 1.hour.ago, delivered_at: 1.hour.ago)
      assert_equal "delivered", message.status
    end
  end

  context "can_edit?" do
    should "return true if message has not been queued, started, or delivered" do
      message = build(:message)
      assert_equal true, message.can_edit?
    end

    should "return false if message has been queued, started, or delivered" do
      message = build(:message, queued_at: 1.hour.ago)
      assert_equal false, message.can_edit?
      message = build(:message, queued_at: 1.hour.ago, started_at: 1.hour.ago)
      assert_equal false, message.can_edit?
      message = build(:message, queued_at: 1.hour.ago, started_at: 1.hour.ago, delivered_at: 1.hour.ago)
      assert_equal false, message.can_edit?
    end
  end

  context "using_default_template?" do
    should "return true if message template is default" do
      message = build(:message)
      assert message.using_default_template?
    end

    should "return false if message template is not default" do
      message = build(:message, template: "accepted")
      assert !message.using_default_template?
    end
  end
end
