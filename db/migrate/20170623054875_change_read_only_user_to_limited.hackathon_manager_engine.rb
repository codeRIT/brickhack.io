# This migration comes from hackathon_manager_engine (originally 20151224015223)
class ChangeReadOnlyUserToLimited < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :admin_read_only, :admin_limited_access
  end
end
