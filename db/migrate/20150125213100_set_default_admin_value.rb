class SetDefaultAdminValue < ActiveRecord::Migration[4.2]
  def up
    change_column :users, :admin, :boolean, default: false
    User.where(admin: nil).each do |u|
      u.admin = false
      u.save
    end
  end

  def down
    change_column :users, :admin, :boolean, default: nil
    User.where(admin: false).each do |u|
      u.admin = nil
      u.save
    end
  end
end
