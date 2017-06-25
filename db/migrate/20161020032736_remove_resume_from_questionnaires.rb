class RemoveResumeFromQuestionnaires < ActiveRecord::Migration[4.2]
  def change
    remove :resume_file_name
    remove :resume_content_type
    remove :resume_file_size
    remove :resume_updated_at
  end

  private

  def remove(column_name)
    remove_column :questionnaires, column_name if column_exists?(:questionnaires, column_name)
  end
end
