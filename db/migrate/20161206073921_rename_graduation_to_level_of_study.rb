class RenameGraduationToLevelOfStudy < ActiveRecord::Migration[5.0]
  def change
    remove_column :questionnaires, :graduation
    add_column    :questionnaires, :level_of_study, :string
  end
end
