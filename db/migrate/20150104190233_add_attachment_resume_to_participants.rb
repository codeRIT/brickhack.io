class AddAttachmentResumeToParticipants < ActiveRecord::Migration
  def self.up
    change_table :participants do |t|
      t.attachment :resume
    end
  end

  def self.down
    drop_attached_file :participants, :resume
  end
end
