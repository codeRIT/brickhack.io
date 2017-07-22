# This migration comes from hackathon_manager_engine (originally 20150110020958)
class AddInternationalToParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :international, :boolean
  end
end
