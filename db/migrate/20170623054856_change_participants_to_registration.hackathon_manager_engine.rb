# This migration comes from hackathon_manager_engine (originally 20150110215933)
class ChangeParticipantsToRegistration < ActiveRecord::Migration[4.2]
  def change
    rename_table :participants, :registrations
  end
end
