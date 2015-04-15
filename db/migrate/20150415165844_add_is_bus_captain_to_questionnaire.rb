class AddIsBusCaptainToQuestionnaire < ActiveRecord::Migration
  def change
    add_column :questionnaires, :is_bus_captain, :boolean, default: false
  end
end
