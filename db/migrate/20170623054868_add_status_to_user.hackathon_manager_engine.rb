# This migration comes from hackathon_manager_engine (originally 20150225235817)
class AddStatusToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :acc_status, :string, default: "pending"
    add_column :questionnaires, :acc_status_author_id, :integer
    add_column :questionnaires, :acc_status_date, :datetime
  end
end
