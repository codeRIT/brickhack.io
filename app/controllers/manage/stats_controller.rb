class Manage::StatsController < Manage::ApplicationController

  def index
  end

  def dietary_special_needs
    attributes = [:first_name,
                  :last_name,
                  :email,
                  :phone,
                  :checked_in_at,
                  :dietary_restrictions,
                  :special_needs]
    select_attributes = Array.new(attributes) << :user_id
    data = Questionnaire.where("dietary_restrictions != '' AND acc_status = 'rsvp_confirmed' OR special_needs != '' AND acc_status = 'rsvp_confirmed'").select(select_attributes)
    render json: { data: to_json_array(data, attributes) }
  end

  def sponsor_info
    attributes = [:first_name,
                  :last_name,
                  :email,
                  :vcs_url,
                  :portfolio_url]
    select_attributes = Array.new(attributes) << :user_id
    data = Questionnaire.where("can_share_info = '1' AND acc_status = 'rsvp_confirmed'").select(select_attributes)
    render json: { data: to_json_array(data, attributes) }
  end

  def alt_travel
    attributes = [:id,
                  :first_name,
                  :last_name,
                  :email,
                  :travel_location,
                  :acc_status]
    select_attributes = Array.new(attributes) << [:user_id, :school_id]
    data = Questionnaire.where("travel_not_from_school = '1'").select(select_attributes)
    json = to_json_array(data, attributes)
    json.each do |e|
      e[0] = view_context.link_to("View &raquo;".html_safe, manage_questionnaire_path(e[0]))
    end
    render json: { data: json }
  end

  def to_json_array(data, attributes)
    data.map { |e| attributes.map { |a| e.send(a) } }
  end

end
