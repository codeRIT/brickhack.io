# This migration comes from hackathon_manager_engine (originally 20171220042158)
class AddWhyAttendToQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    add_column :questionnaires, :why_attend, :text
  end
end
