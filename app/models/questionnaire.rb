class Questionnaire < ApplicationRecord
  include ActiveModel::Dirty

  before_validation :consolidate_school_names
  after_save :update_school_questionnaire_count
  after_destroy :update_school_questionnaire_count

  validates_presence_of :first_name, :last_name, :phone, :date_of_birth, :school_id, :experience, :shirt_size, :interest
  validates_presence_of :gender, :major, :level_of_study
  validates_presence_of :agreement_accepted, message: "Must accept"
  validates_presence_of :code_of_conduct_accepted, message: "Must accept"
  validates_presence_of :data_sharing_accepted, message: "Must accept"

  has_attached_file :resume
  validates_attachment_content_type :resume, content_type: %w(application/pdf), message: "Invalid file type"
  validates_attachment_size :resume, in: 0..2.megabytes, message: "File size is too big"

  include DeletableAttachment

  validates :portfolio_url, url: { allow_blank: true }
  validates :vcs_url, url: { allow_blank: true }
  validates_format_of :vcs_url, with: /((github.com\/\w+\/?)|(bitbucket.org\/\w+\/?))/, allow_blank: true, message: "Must be a GitHub or BitBucket url"

  belongs_to :school

  strip_attributes

  POSSIBLE_EXPERIENCES = {
    "first"       => "This is my 1st hackathon!",
    "experienced" => "My feet are wet. (1-5 hackathons)",
    "expert"      => "I'm a veteran hacker. (6+ hackathons)"
  }.freeze

  POSSIBLE_INTERESTS = {
    "design"      => "Design",
    "software"    => "Software",
    "hardware"    => "Hardware",
    "combination" => "Combination of everything!"
  }.freeze

  POSSIBLE_SHIRT_SIZES = [
    "Women's - XS",
    "Women's - S",
    "Women's - M",
    "Women's - L",
    "Women's - XL",
    "Unisex - XS",
    "Unisex - S",
    "Unisex - M",
    "Unisex - L",
    "Unisex - XL"
  ].freeze

  POSSIBLE_ACC_STATUS = {
    "pending"        => "Pending Review",
    "accepted"       => "Accepted",
    "waitlist"       => "Waitlisted",
    "denied"         => "Denied",
    "late_waitlist"  => "Waitlisted, Late",
    "rsvp_confirmed" => "RSVP Confirmed",
    "rsvp_denied"    => "RSVP Denied"
  }.freeze

  validates_inclusion_of :experience, in: POSSIBLE_EXPERIENCES
  validates_inclusion_of :interest, in: POSSIBLE_INTERESTS
  # validates_inclusion_of :school_id, :in => School.select(:id)
  validates_inclusion_of :shirt_size, in: POSSIBLE_SHIRT_SIZES
  validates_inclusion_of :acc_status, in: POSSIBLE_ACC_STATUS

  belongs_to :user

  def email
    user.email
  end

  def portfolio_url=(value)
    value = "http://" + value if !value.blank? && !value.include?("http://") && !value.include?("https://")
    super value
  end

  def vcs_url=(value)
    value = "http://" + value if !value.blank? && !value.include?("http://") && !value.include?("https://")
    super value
  end

  def school
    School.find(school_id) if school_id
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_location
    "#{school.city}, #{school.state}"
  end

  def date_of_birth_formatted
    date_of_birth.strftime("%B %-d, %Y")
  end

  def acc_status_author
    return unless acc_status_author_id.present?
    User.find(acc_status_author_id)
  end

  def checked_in?
    checked_in_at.present?
  end

  def checked_in_by
    return unless checked_in_by_id.present?
    User.find(checked_in_by_id)
  end

  def fips_code
    Fips.where(city: school.city, state: school.state).first
  end

  def can_rsvp?
    ["accepted", "rsvp_confirmed", "rsvp_denied"].include? acc_status
  end

  def did_rsvp?
    ['rsvp_confirmed', 'rsvp_denied'].include? acc_status
  end

  def eligible_for_a_bus?
    school.present? && school.bus_list_id?
  end

  def bus_list
    return unless eligible_for_a_bus?
    school.bus_list
  end

  def message_events
    return [] unless ENV['SPARKPOST_API_KEY']

    simple_spark = SimpleSpark::Client.new
    simple_spark.message_events.search(recipients: email)
  end

  def invite_to_slack
    SlackInviteWorker.perform_async(id)
  end

  private

  def consolidate_school_names
    return if school.blank?
    duplicate = SchoolNameDuplicate.find_by(name: school.name)
    return if duplicate.blank?
    self.school_id = duplicate.school_id
  end

  def update_school_questionnaire_count
    if destroyed?
      School.decrement_counter(:questionnaire_count, school_id)
    elsif saved_change_to_school_id?
      old_school_id = saved_changes['school_id'].first
      School.decrement_counter(:questionnaire_count, old_school_id) if old_school_id.present?
      School.increment_counter(:questionnaire_count, school_id)
    end
  end
end
