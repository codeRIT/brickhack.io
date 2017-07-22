# This migration comes from hackathon_manager_engine (originally 20161212030010)
class AddInterestToQuestionnaire < ActiveRecord::Migration[5.0]
  def change
    add_column :questionnaires, :interest, :string
  end
end
