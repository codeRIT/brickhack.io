class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :city
      t.string :state
      t.string :experience
      t.string :year
      t.string :interest
      t.string :school_id

      t.timestamps
    end
  end
end
