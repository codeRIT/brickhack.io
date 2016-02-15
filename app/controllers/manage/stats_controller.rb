class Manage::StatsController < Manage::ApplicationController

  def index
  end

  def dietary_special_needs
    attributes = [:first_name,
                  :last_name,
                  :phone,
                  :email,
                  :checked_in_at,
                  :dietary_restrictions,
                  :special_needs]
    data = Questionnaire.where("dietary_restrictions != '' AND acc_status = 'rsvp_confirmed' OR special_needs != '' AND acc_status = 'rsvp_confirmed'").select(attributes << [:user_id])
    render json: { data: to_json_array(data, attributes) }
  end

  def to_json_array(data, attributes)
    data.map { |e| attributes.map { |a| e[a] } }
  end

end
