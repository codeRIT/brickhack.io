class AddInternationalToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :international, :boolean
  end
end
