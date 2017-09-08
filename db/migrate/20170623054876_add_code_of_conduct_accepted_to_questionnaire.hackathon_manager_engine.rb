# This migration comes from hackathon_manager_engine (originally 20160110012217)
class AddCodeOfConductAcceptedToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :code_of_conduct_accepted, :boolean, default: false
  end
end
