class Message < ActiveRecord::Base

  attr_accessible :name, :subject, :recipients, :template, :body

  validates_presence_of :name, :subject, :recipients, :template, :body

  strip_attributes

  POSSIBLE_TEMPLATES = ["default", "accepted"]

  POSSIBLE_RECIPIENTS = {
    "all"        => "Everyone",
    "incomplete" => "Incomplete Applications",
    "complete"   => "Complete Applications",
    "accepted"   => "Accepted Applications",
    "denied"     => "Denied Applications",
    "waitlisted" => "Waitlisted Applications",
    "late-waitlisted" => "Late, Waitlisted Applications",
    "rsvp-confirmed" => "RSVP Confirmed Attendees",
    "rsvp-denied" => "RSVP Denied Attendees"
  }
  serialize :recipients, Array

  validates_inclusion_of :template, in: POSSIBLE_TEMPLATES

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
