# This migration comes from hackathon_manager_engine (originally 20190107232955)
class CreateTrackableTags < ActiveRecord::Migration[5.2]
  def change
    create_table :trackable_tags do |t|
      t.string :name

      t.timestamps
    end
    add_index :trackable_tags, :name, unique: true
  end
end
