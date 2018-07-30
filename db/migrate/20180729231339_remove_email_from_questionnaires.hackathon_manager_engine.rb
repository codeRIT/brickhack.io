# This migration comes from hackathon_manager_engine (originally 20180701160855)
class RemoveEmailFromQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    remove_column :questionnaires, :email, :string
  end
end
