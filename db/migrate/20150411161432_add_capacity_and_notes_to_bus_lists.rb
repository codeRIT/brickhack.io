class AddCapacityAndNotesToBusLists < ActiveRecord::Migration
  def change
    add_column :bus_lists, :capacity, :integer, default: 50
    add_column :bus_lists, :notes, :text
  end
end
