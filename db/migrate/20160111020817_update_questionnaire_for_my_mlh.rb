class UpdateQuestionnaireForMyMlh < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :special_needs, :string
    add_column :questionnaires, :gender, :string
    add_column :questionnaires, :graduation, :date
    add_column :questionnaires, :major, :string
    rename_column :questionnaires, :dietary_medical_notes, :dietary_restrictions
    rename_column :questionnaires, :birthday, :date_of_birth
    remove_column :questionnaires, :city, :string
    remove_column :questionnaires, :state, :string
    remove_column :questionnaires, :year, :int
    remove_column :questionnaires, :interest, :string
  end
end
