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

  def user_distribution_data
    totalStatsData = {}
    total_count = Questionnaire.count
    rit_count = Questionnaire.where("school_id = \"2304\"").count
    totalStatsData["Non-Applied Users"] = User.count - total_count
    totalStatsData["Non-RIT Applications"] = total_count - rit_count
    totalStatsData["RIT Applications"] = rit_count
    render :json => totalStatsData
  end

  def application_distribution_data
    groups = Questionnaire.group(:acc_status).count
    groups.keys.each { |short_status, count| groups[Questionnaire::POSSIBLE_ACC_STATUS[short_status]] = groups.delete(short_status) }
    render json: groups
  end

  def schools_confirmed_data
    schools = Questionnaire.joins(:school).group('schools.name').where("acc_status = 'rsvp_confirmed'").count
    render :json => schools.sort_by { |name, count| count }.reverse
  end

  def schools_applied_data
    counted_schools = {
      "pending" => {},
      "denied" => {},
      "rsvp_denied" => {},
      "late_waitlist" => {},
      "waitlist" => {},
      "accepted" => {},
      "rsvp_confirmed" => {}
    }
    result = Questionnaire.joins(:school).group(:acc_status, "schools.name").where("schools.questionnaire_count >= 5").order("schools.questionnaire_count DESC").count
    result.each do |group, count|
      counted_schools[group[0]][group[1]] = count
    end
    render :json => [{ name: "RSVP Confirmed", data: counted_schools["rsvp_confirmed"]}, { name: "Accepted", data: counted_schools["accepted"]},  { name: "Waitlisted", data: counted_schools["waitlist"]}, { name: "Late Waitlisted", data: counted_schools["late_waitlist"]}, { name: "RSVP Denied", data: counted_schools["rsvp_denied"]}, { name: "Denied", data: counted_schools["denied"]}, { name: "Pending", data: counted_schools["pending"]}]
  end

  private

  def activity_chart_data(types, group_type, range)
    chart_data = []
    types.each do |type|
      case type
      when "Applications"
        data = Questionnaire.send("group_by_#{group_type}", :created_at, range: range).count
      when "RIT Applications"
        data = Questionnaire.where("school_id = \"2304\"").send("group_by_#{group_type}", :created_at, range: range).count
      when "Non-RIT Applications"
        data = Questionnaire.where("school_id != \"2304\"").send("group_by_#{group_type}", :created_at, range: range).count
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
