class ChangeParticipantsToRegistration < ActiveRecord::Migration[4.2]
  def change
    rename_table :participants, :registrations
  end
end
