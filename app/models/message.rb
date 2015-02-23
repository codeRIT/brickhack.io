class Message < ActiveRecord::Base

  attr_accessible :name, :subject, :recipients, :body

  validates_presence_of :name, :subject, :recipients, :body

  strip_attributes

  POSSIBLE_RECIPIENTS = {
    "all"        => "Everyone",
    "incomplete" => "Incomplete Applications",
    "complete"   => "Complete Applications",
    # "accepted"   => "Accepted Applications" not implemented
    # "rejected"   => "Rejected Applications" not implemented
    # "awaiting-rsvp" => "Awaiting RSVP Applications" not implemented
  }
  serialize :recipients, Array

  def recipients=(values)
    values.present? ? super(values.reject(&:blank?)) : super(values)
  end

  def recipients_list
    recipients.map { |r| POSSIBLE_RECIPIENTS[r] }.join(', ')
  end

  def delivered?
    delivered_at.present?
  end

  def started?
    started_at.present?
  end

  def queued?
    queued_at.present?
  end

  def status
    return "delivered" if delivered?
    return "started" if started?
    return "queued" if queued?
    "drafted"
  end

  def can_edit?
    status == "drafted"
  end

end
