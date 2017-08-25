# This migration comes from hackathon_manager_engine (originally 20170107210122)
class CreateSchoolNameDuplicates < ActiveRecord::Migration[5.0]
  def change
    create_table :school_name_duplicates do |t|
      t.string :name
      t.belongs_to :school, foreign_key: true

      t.timestamps
    end
  end
end
