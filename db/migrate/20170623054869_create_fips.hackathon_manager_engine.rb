# This migration comes from hackathon_manager_engine (originally 20150302011457)
class CreateFips < ActiveRecord::Migration[4.2]
  def change
    create_table :fips do |t|
      t.string :fips_code
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
