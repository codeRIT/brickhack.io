# This migration comes from hackathon_manager_engine (originally 20190107233210)
class CreateTrackableEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :trackable_events do |t|
      t.string :band_id
      t.references :trackable_tag, foreign_key: true
      t.references :user, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end
