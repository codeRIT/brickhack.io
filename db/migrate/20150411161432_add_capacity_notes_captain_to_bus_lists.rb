class AddCapacityNotesCaptainToBusLists < ActiveRecord::Migration[4.2]
  def change
    add_column :bus_lists, :capacity, :integer, default: 50
    add_column :bus_lists, :notes, :text
    add_column :bus_lists, :needs_bus_captain, :boolean, default: false
    add_column :questionnaires, :bus_captain_interest, :boolean, default: false
  end
end
