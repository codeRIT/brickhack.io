class ChangeResgistrationsToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    rename_table :registrations, :questionnaires
  end
end
