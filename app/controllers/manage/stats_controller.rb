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

  def to_json_array(data, attributes)
    data.map { |e| attributes.map { |a| e.send(a) } }
  end

end
