module Manage::DashboardHelper

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
