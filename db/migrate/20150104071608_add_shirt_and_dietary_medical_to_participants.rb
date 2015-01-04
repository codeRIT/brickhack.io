class AddShirtAndDietaryMedicalToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :shirt_size, :string
    add_column :participants, :dietary_medical_notes, :string
  end
end
