# This migration comes from hackathon_manager_engine (originally 20150111000224)
class ChangeResgistrationsToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    rename_table :registrations, :questionnaires
  end
end
