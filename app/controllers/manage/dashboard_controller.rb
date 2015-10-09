class Manage::DashboardController < Manage::ApplicationController

  def index
  end

  def map_data
    @schools = School.where("questionnaire_count", 1..Float::INFINITY).select([:city, :state, :questionnaire_count])
  end

  def todays_activity_data
    render :json => activity_chart_data(["Applications", "Confirmations", "Denials"], "hour", Date.today.beginning_of_day..Date.today.end_of_day)
  end

  def todays_stats_data
    date_min = Date.today.beginning_of_day
    render :json => { "Applications" => Questionnaire.where("created_at >= :date_min", date_min: date_min).count, "Confirmations" => Questionnaire.where("acc_status = \"rsvp_confirmed\" AND acc_status_date >= :date_min", date_min: date_min).count, "Denials" => Questionnaire.where("acc_status = \"rsvp_denied\" AND acc_status_date >= :date_min", date_min: date_min).count }
  end

  def confirmation_activity_data
    render :json => activity_chart_data(["Confirmations", "Denials"], "day", 2.week.ago..Time.now)
  end

  def application_activity_data
    render :json => activity_chart_data(["Non-RIT Applications", "RIT Applications"], "day", 2.week.ago..Time.now)
  end

  def schools_confirmed_data
    schools = Questionnaire.where(acc_status: "rsvp_confirmed").select([:school_id]).map(&:school)
    counted_confirmed_schools = {}
    schools.each do |school|
      counted_confirmed_schools[school.name] ||= 0
      counted_confirmed_schools[school.name] += 1
    end
    render :json => counted_confirmed_schools.sort_by { |name, count| count }.reverse
  end

  def user_distribution_data
    totalStatsData = {}
    rit_count = Questionnaire.where("school_id = \"2304\" OR school_id = \"5535\"").count
    totalStatsData["Non-Applied Users"] = User.count - Questionnaire.count
    totalStatsData["Non-RIT Applications"] = Questionnaire.count - rit_count
    totalStatsData["RIT Applications"] = rit_count
    render :json => totalStatsData
  end

  def application_distribution_data
    render json: { "Accepted" => Questionnaire.where(acc_status: "accepted").count, "RSVP Confirmed" => Questionnaire.where(acc_status: "rsvp_confirmed").count, "RSVP Denied" => Questionnaire.where(acc_status: "rsvp_denied").count, "Denied" => Questionnaire.where(acc_status: "denied").count, "Waitlisted" => Questionnaire.where(acc_status: "waitlist").count, "Late Waitlisted" => Questionnaire.where(acc_status: "late_waitlist").count }
  end

  def schools_confirmed_data
    schools = Questionnaire.where(acc_status: "rsvp_confirmed").select([:school_id]).map(&:school)
    counted_confirmed_schools = {}
    schools.each do |school|
      counted_confirmed_schools[school.name] ||= 0
      counted_confirmed_schools[school.name] += 1
    end
    render :json => counted_confirmed_schools.sort_by { |name, count| count }.reverse
  end

  def schools_applied_data
    counted_schools_denied = {}
    counted_schools_rsvp_denied = {}
    counted_schools_late_waitlist = {}
    counted_schools_waitlist = {}
    counted_schools_accepted = {}
    counted_schools_rsvp_confirmed = {}
    counted_schools = {}
    schools = School.where("questionnaire_count >= 5").select([:id, :name]).order("questionnaire_count DESC")
    schools.each do |school|
      counted_schools[school.name] = Questionnaire.where(school_id: school.id).select([:id, :acc_status]).group_by(&:acc_status).map { |a, b| { a => b.count } }
    end
    counted_schools.each do |school_name, data|
      data = data.reduce Hash.new, :merge
      counted_schools_denied[school_name] = data["denied"] || 0
      counted_schools_rsvp_denied[school_name] = data["rsvp_denied"] || 0
      counted_schools_late_waitlist[school_name] = data["late_waitlist"] || 0
      counted_schools_waitlist[school_name] = data["waitlist"] || 0
      counted_schools_accepted[school_name] = data["accepted"] || 0
      counted_schools_rsvp_confirmed[school_name] = data["rsvp_confirmed"] || 0
    end
    render :json => [{ name: "RSVP Confirmed", data: counted_schools_rsvp_confirmed}, { name: "Accepted", data: counted_schools_accepted},  { name: "Waitlisted", data: counted_schools_waitlist}, { name: "Late Waitlisted", data: counted_schools_late_waitlist}, { name: "RSVP Denied", data: counted_schools_rsvp_denied}, { name: "Denied", data: counted_schools_denied}]
  end

  private

  def activity_chart_data(types, group_type, range)
    chart_data = []
    types.each do |type|
      case type
      when "Applications"
        data = Questionnaire.send("group_by_#{group_type}", :created_at, range: range).count
      when "RIT Applications"
        data = Questionnaire.where("school_id = \"2304\" OR school_id = \"5535\"").send("group_by_#{group_type}", :created_at, range: range).count
      when "Non-RIT Applications"
        data = Questionnaire.where("school_id != \"2304\" OR school_id != \"5535\"").send("group_by_#{group_type}", :created_at, range: range).count
      when "Confirmations"
        data = Questionnaire.where(acc_status: "rsvp_confirmed").send("group_by_#{group_type}", :acc_status_date, range: range).count
      when "Denials"
        data = Questionnaire.where(acc_status: "rsvp_denied").send("group_by_#{group_type}", :acc_status_date, range: range).count
      end
      chart_data << { name: type, data: data }
    end
    chart_data
  end
end
