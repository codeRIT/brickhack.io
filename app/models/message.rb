class Message < ActiveRecord::Base

  attr_accessible :name, :subject, :recipients, :template, :body

  validates_presence_of :name, :subject, :recipients, :template
  validates_presence_of :body, if: :using_default_template?

  strip_attributes

  POSSIBLE_TEMPLATES = ["default"]

  POSSIBLE_RECIPIENTS = {
    "all"        => "Everyone",
    "incomplete" => "Incomplete Applications",
    "complete"   => "Complete Applications",
    "accepted"   => "Accepted Applications",
    "denied"     => "Denied Applications",
    "waitlisted" => "Waitlisted Applications",
    "late-waitlisted" => "Late, Waitlisted Applications",
    "rsvp-confirmed" => "RSVP Confirmed Attendees",
    "rsvp-denied" => "RSVP Denied Attendees",
    "checked-in" => "Checked-In Attendees",
    "bus-list-cornell" => "Bus List: Cornell (Confirmed)",
    "bus-list-binghamton" => "Bus List: Binghamton (Confirmed)",
    "bus-list-buffalo" => "Bus List: Buffalo (Confirmed)",
    "school-cornell" => "School: Cornell",
    "school-binghamton" => "School: Binghamton",
    "school-buffalo" => "School: Buffalo",
    "school-waterloo" => "School: Waterloo",
    "school-toronto" => "School: Toronto"
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

  def using_default_template?
    template == "default"
  end
  
end
