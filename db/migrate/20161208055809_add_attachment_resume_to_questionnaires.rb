class AddAttachmentResumeToQuestionnaires < ActiveRecord::Migration[4.2]
  def self.up
    change_table :questionnaires do |t|
      t.attachment :resume
    end
  end

  def self.down
    remove_attachment :questionnaires, :resume
  end
end
