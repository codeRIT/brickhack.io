class AddCheckInDataToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :checked_in_by_id, :integer
    add_column :questionnaires, :checked_in_at, :datetime
    add_column :questionnaires, :phone, :string
    add_column :questionnaires, :can_share_resume, :boolean, default: false
  end
end
