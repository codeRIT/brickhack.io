class Manage::StatsController < Manage::ApplicationController
  def index
  end

  def dietary_special_needs
    data = Rails.cache.fetch(cache_key_for_questionnaires("dietary_special_needs")) do
      attributes = [:first_name,
                    :last_name,
                    :email,
                    :phone,
                    :checked_in_at,
                    :dietary_restrictions,
                    :special_needs]
      select_attributes = Array.new(attributes) << :user_id
      data = Questionnaire.where("dietary_restrictions != '' AND acc_status = 'rsvp_confirmed' OR special_needs != '' AND acc_status = 'rsvp_confirmed'").select(select_attributes)
      to_json_array(data, attributes)
    end
    render json: { data: data }
  end

  def sponsor_info
    data = Rails.cache.fetch(cache_key_for_questionnaires("sponsor_info")) do
      attributes = [:first_name,
                    :last_name,
                    :email,
                    :vcs_url,
                    :portfolio_url]
      select_attributes = Array.new(attributes) << :user_id
      data = Questionnaire.where("can_share_info = '1' AND acc_status = 'rsvp_confirmed'").select(select_attributes)
      to_json_array(data, attributes)
    end
    render json: { data: data }
  end

  def alt_travel
    data = Rails.cache.fetch(cache_key_for_questionnaires("alt_travel")) do
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
    end
    render json: { data: data }
  end

  def mlh_info
    data = Rails.cache.fetch(cache_key_for_questionnaires("mlh_info")) do
      attributes = [:first_name,
                    :last_name,
                    :email,
                    :phone]
      select_attributes = Array.new(attributes) << :user_id
      data = Questionnaire.select(select_attributes)
      to_json_array(data, attributes)
    end
    render json: { data: data }
  end

  private

  def to_json_array(data, attributes)
    data.map { |e| attributes.map { |a| e.send(a) } }
  end

  def cache_key_for_questionnaires(id)
    count          = Questionnaire.count
    max_updated_at = Questionnaire.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "stats/all-#{count}-#{max_updated_at}-#{id}"
  end
end
