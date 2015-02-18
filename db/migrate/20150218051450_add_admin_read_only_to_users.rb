class AddAdminReadOnlyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin_read_only, :boolean, default: false
  end
end
