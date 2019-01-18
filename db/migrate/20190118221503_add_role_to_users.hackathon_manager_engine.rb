# This migration comes from hackathon_manager_engine (originally 20190118204143)
class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :role, :integer, default: 0

    User.where(admin: true).each do |user|
      user.update_attribute(:role, :admin)
    end

    User.where(admin_limited_access: true).each do |user|
      user.update_attribute(:role, :admin_limited_access)
    end

    remove_column :users, :admin, :boolean
    remove_column :users, :admin_limited_access, :boolean
  end
end
