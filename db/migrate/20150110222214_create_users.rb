class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, &:timestamps
  end
end
