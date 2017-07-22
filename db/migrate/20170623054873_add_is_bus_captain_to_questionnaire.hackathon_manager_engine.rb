# This migration comes from hackathon_manager_engine (originally 20150415165844)
class AddIsBusCaptainToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :is_bus_captain, :boolean, default: false
  end
end
