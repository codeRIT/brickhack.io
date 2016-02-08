class RenameCanShareResumeToInfo < ActiveRecord::Migration
  def change
    rename_column :questionnaires, :can_share_resume, :can_share_info
  end
end
