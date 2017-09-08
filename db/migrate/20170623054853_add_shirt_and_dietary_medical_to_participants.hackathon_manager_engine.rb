# This migration comes from hackathon_manager_engine (originally 20150104071608)
class AddShirtAndDietaryMedicalToParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :shirt_size, :string
    add_column :participants, :dietary_medical_notes, :string
  end
end
