class AddIsBusCaptainToQuestionnaire < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :is_bus_captain, :boolean, default: false
  end
end
