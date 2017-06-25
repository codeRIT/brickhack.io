class AddQuestionnaireRefToUsers < ActiveRecord::Migration[4.2]
  def change
    change_table(:questionnaires) do |t|
      t.references :user
    end
    add_index :questionnaires, :user_id
  end
end
