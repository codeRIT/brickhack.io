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
    data = Questionnaire.where("dietary_restrictions != '' AND acc_status = 'rsvp_confirmed' OR special_needs != '' AND acc_status = 'rsvp_confirmed'").select(attributes << [:user_id]).map { |e| [e.first_name, e.last_name, e.email, e.phone, e.checked_in_at, e.dietary_restrictions, e.special_needs] }
    render json: { data: data }
  end

end
