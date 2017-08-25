# This migration comes from hackathon_manager_engine (originally 20150104190233)
class AddAttachmentResumeToParticipants < ActiveRecord::Migration[4.2]
  # Paperclip was removed on 10/19/2016 by Stuart Olivera

  # def self.up
  #   change_table :participants do |t|
  #     t.attachment :resume
  #   end
  # end

  # def self.down
  #   drop_attached_file :participants, :resume
  # end
end
