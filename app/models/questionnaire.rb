class Questionnaire < ActiveRecord::Base
  include ActiveModel::Dirty

  after_save :update_school_questionnaire_count
  after_destroy :update_school_questionnaire_count

  attr_accessible :email, :experience, :first_name, :last_name, :gender
  attr_accessible :date_of_birth, :experience, :school_id, :school_name, :major, :graduation
  attr_accessible :shirt_size, :dietary_restrictions, :special_needs, :international
  attr_accessible :portfolio_url, :vcs_url, :agreement_accepted, :bus_captain_interest
  attr_accessible :riding_bus, :phone, :can_share_info, :code_of_conduct_accepted
  attr_accessible :travel_not_from_school, :travel_location

  validates_presence_of :first_name, :last_name, :phone, :date_of_birth, :school_id, :experience, :shirt_size
  validates_presence_of :gender, :major, :graduation
  validates_presence_of :agreement_accepted, message: "Must accept"
  validates_presence_of :code_of_conduct_accepted, message: "Must accept"

  validates :portfolio_url, url: { allow_blank: true }
  validates :vcs_url, url: { allow_blank: true }
  validates_format_of :vcs_url, with: /((github.com\/\w+\/?)|(bitbucket.org\/\w+\/?))/, allow_blank: true, message: "Must be a GitHub or BitBucket url"

  belongs_to :school

  strip_attributes

  POSSIBLE_EXPERIENCES = {
    "first"       => "This is my 1st hackathon!",
    "experienced" => "My feet are wet. (1-5 hackathons)",
    "expert"      => "I'm a veteran hacker. (6+ hackathons)"
  }
  POSSIBLE_YEARS       = {
    "hs" => "High School",
    "1"  => "1st Year",
    "2"  => "2nd Year",
    "3"  => "3rd Year",
    "4"  => "4th Year",
    "5+" => "5th+ Year"
  }
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
    "Unisex - XL",
  ]
  POSSIBLE_ACC_STATUS = {
    "pending"        => "Pending Review",
    "accepted"       => "Accepted",
    "waitlist"       => "Waitlisted",
    "denied"         => "Denied",
    "late_waitlist"  => "Waitlisted, Late",
    "rsvp_confirmed" => "RSVP Confirmed",
    "rsvp_denied"    => "RSVP Denied"
  }

  validates_inclusion_of :experience, in: POSSIBLE_EXPERIENCES
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

  def graduation_formatted
    graduation.strftime("%B %Y")
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

  def can_ride_bus?
    school.present? && school.bus_list_id?
  end

  def bus_list
    return unless can_ride_bus?
    school.bus_list
  end

  private

  def update_school_questionnaire_count
    if school_id_changed?
      School.decrement_counter(:questionnaire_count, school_id_was) if school_id_was.present?
      School.increment_counter(:questionnaire_count, school_id)
    elsif destroyed?
      School.decrement_counter(:questionnaire_count, school_id)
    end
  end
end
