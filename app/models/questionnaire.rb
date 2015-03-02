class Questionnaire < ActiveRecord::Base
  include ActiveModel::Dirty

  after_save :update_school_questionnaire_count
  after_destroy :update_school_questionnaire_count

  attr_accessible :city, :email, :experience, :first_name, :last_name, :state, :year
  attr_accessible :birthday, :interest, :experience, :school_id, :school_name
  attr_accessible :shirt_size, :dietary_medical_notes, :resume, :international
  attr_accessible :portfolio_url, :vcs_url, :agreement_accepted

  validates_presence_of :first_name, :last_name, :city, :city, :state, :year
  validates_presence_of :birthday, :school_id, :interest, :experience, :shirt_size
  validates_presence_of :agreement_accepted, message: "Must accept"

  has_attached_file :resume
  validates_attachment_content_type :resume, content_type: %w(application/pdf), message: "Invalid file type"
  validates_attachment_size :resume, in: 0..2.megabytes, message: "File size is too big"

  include DeletableAttachment

  validates :portfolio_url, url: { allow_blank: true }
  validates :vcs_url, url: { allow_blank: true }
  validates_format_of :vcs_url, with: /((github.com\/\w+\/?)|(bitbucket.org\/\w+\/?))/, allow_blank: true, message: "Must be a GitHub or BitBucket url"

  belongs_to :school

  strip_attributes

  POSSIBLE_STATES      = %w(AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA PR RI SC SD TN TX UT VT VA WA WV WI WY)
  POSSIBLE_INTERESTS   = %w(Design Development Hardware)
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
  POSSIBLE_SHIRT_SIZES = {
    "S"  => "Small",
    "M"  => "Medium",
    "L"  => "Large",
    "XL" => "X-Large"
  }
  POSSIBLE_ACC_STATUS = {
    "pending"  => "Pending Review",
    "accepted" => "Accepted",
    "waitlist" => "Waitlisted",
    "denied"   => "Denied"
  }

  validates_inclusion_of :state, in: POSSIBLE_STATES, unless: :international
  validates_inclusion_of :interest, in: POSSIBLE_INTERESTS
  validates_inclusion_of :experience, in: POSSIBLE_EXPERIENCES
  validates_inclusion_of :year, in: POSSIBLE_YEARS
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
    School.find(school_id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_location
    "#{city}, #{state}"
  end

  def birthday_formatted
    birthday.strftime("%B %-d, %Y")
  end

  def acc_status_author
    return unless acc_status_author_id.present?
    User.find(acc_status_author_id)
  end

  def fips_code
    Fips.where(city: school.city, state: school.state).first
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
