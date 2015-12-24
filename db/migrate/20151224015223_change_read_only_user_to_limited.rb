class ChangeReadOnlyUserToLimited < ActiveRecord::Migration
  def change
    rename_column :users, :admin_read_only, :admin_limited_access
  end
end
