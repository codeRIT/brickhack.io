# This migration comes from hackathon_manager_engine (originally 20161206084722)
class AddReminderSentAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reminder_sent_at, :datetime
  end
end
