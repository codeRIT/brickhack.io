class ChangeParticipantsToRegistration < ActiveRecord::Migration
  def change
    rename_table :participants, :registrations
  end
end
