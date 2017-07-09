class CreateBusLists < ActiveRecord::Migration[4.2]
  def change
    create_table :bus_lists do |t|
      t.string :name

      t.timestamps
    end

    add_column :schools, :bus_list_id, :integer
    add_column :questionnaires, :riding_bus, :boolean, default: false
  end
end
