# This migration comes from hackathon_manager_engine (originally 20160112222137)
class AddOptionForAltTravelToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :travel_not_from_school, :boolean, default: false
    add_column :questionnaires, :travel_location, :string
  end
end
