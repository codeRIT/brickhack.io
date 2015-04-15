class AddCheckedInAtToQuestionnaires < ActiveRecord::Migration
  def change
    add_column :questionnaires, :checked_in_by_id, :integer
    add_column :questionnaires, :checked_in_at, :datetime
  end
end
