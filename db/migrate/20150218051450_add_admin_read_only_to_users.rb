class AddAdminReadOnlyToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :admin_read_only, :boolean, default: false
  end
end
