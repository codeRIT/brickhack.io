# This migration comes from hackathon_manager_engine (originally 20190213233902)
class AddPreventDuplicateBandEventsToTrackableTags < ActiveRecord::Migration[5.2]
  def change
    add_column :trackable_tags, :allow_duplicate_band_events, :bool, null: false, default: true
  end
end
