# This migration comes from hackathon_manager_engine (originally 20141029055313)
class CreateSchools < ActiveRecord::Migration[4.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
