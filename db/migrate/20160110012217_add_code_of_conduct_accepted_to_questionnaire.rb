class AddCodeOfConductAcceptedToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :code_of_conduct_accepted, :boolean, default: false
  end
end
