# This migration comes from hackathon_manager_engine (originally 20160110222639)
class AddOmniauthToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :provider, :string
    add_index :users, :provider
    add_column :users, :uid, :string
    add_index :users, :uid
  end
end
