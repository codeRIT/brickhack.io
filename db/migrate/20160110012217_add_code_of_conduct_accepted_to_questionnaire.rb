class AddCodeOfConductAcceptedToQuestionnaire < ActiveRecord::Migration
  def change
    add_column :questionnaires, :code_of_conduct_accepted, :boolean, default: false
  end
end
