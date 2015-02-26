class AddStatusToUser < ActiveRecord::Migration
  def change
    add_column :questionnaires, :acc_status, :string, default: "pending"
    add_column :questionnaires, :acc_status_author_id, :integer
    add_column :questionnaires, :acc_status_date, :datetime
  end
end
