class AddDataSharingToQuestionnaire < ActiveRecord::Migration[5.0]
  def change
    add_column :questionnaires, :data_sharing_accepted, :boolean
  end
end
