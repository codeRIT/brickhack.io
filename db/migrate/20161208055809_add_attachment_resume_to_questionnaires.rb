class AddAttachmentResumeToQuestionnaires < ActiveRecord::Migration
  def self.up
    change_table :questionnaires do |t|
      t.attachment :resume
    end
  end

  def self.down
    remove_attachment :questionnaires, :resume
  end
end
