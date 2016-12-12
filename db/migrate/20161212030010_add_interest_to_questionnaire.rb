class AddInterestToQuestionnaire < ActiveRecord::Migration[5.0]
  def change
    add_column :questionnaires, :interest, :string
  end
end
