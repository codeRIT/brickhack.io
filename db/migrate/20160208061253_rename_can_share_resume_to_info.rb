class RenameCanShareResumeToInfo < ActiveRecord::Migration[4.2]
  def change
    rename_column :questionnaires, :can_share_resume, :can_share_info
  end
end
