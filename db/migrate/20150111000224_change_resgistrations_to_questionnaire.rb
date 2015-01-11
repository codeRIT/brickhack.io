class ChangeResgistrationsToQuestionnaire < ActiveRecord::Migration
  def change
    rename_table :registrations, :questionnaires
  end
end
