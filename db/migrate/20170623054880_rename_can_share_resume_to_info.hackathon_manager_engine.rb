# This migration comes from hackathon_manager_engine (originally 20160208061253)
class RenameCanShareResumeToInfo < ActiveRecord::Migration[4.2]
  def change
    rename_column :questionnaires, :can_share_resume, :can_share_info
  end
end
