class AddQuestionnaireRefToUsers < ActiveRecord::Migration
  def change
    change_table(:questionnaires) do |t|
      t.references :user
    end
    add_index :questionnaires, :user_id
  end
end
