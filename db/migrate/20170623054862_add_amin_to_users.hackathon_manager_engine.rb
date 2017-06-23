# This migration comes from hackathon_manager_engine (originally 20150113205638)
class AddAminToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :admin, :boolean
  end
end
