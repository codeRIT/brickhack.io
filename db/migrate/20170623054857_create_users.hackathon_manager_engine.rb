# This migration comes from hackathon_manager_engine (originally 20150110222214)
class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users, &:timestamps
  end
end
