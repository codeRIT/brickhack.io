# This migration comes from hackathon_manager_engine (originally 20180108231420)
class AddTriggerToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :trigger, :string
  end
end
