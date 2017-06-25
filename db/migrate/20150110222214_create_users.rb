class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users, &:timestamps
  end
end
