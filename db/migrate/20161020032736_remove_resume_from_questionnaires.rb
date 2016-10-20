class RemoveResumeFromQuestionnaires < ActiveRecord::Migration
  def change
    remove_column :questionnaires, :resume_file_name
    remove_column :questionnaires, :resume_content_type
    remove_column :questionnaires, :resume_file_size
    remove_column :questionnaires, :resume_updated_at
  end
end
