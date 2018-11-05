# This migration comes from hackathon_manager_engine (originally 20180801144544)
class AddTypeToMessages < ActiveRecord::Migration[5.1]
  def up
    add_column :messages, :type, :string

    Message.all.each do |message|
      if message.trigger.present?
        message.update_attribute(:type, 'automated')
      else
        message.update_attribute(:type, 'bulk')
      end
    end
  end

  def down
    remove_column :messages, :type, :string
  end
end
