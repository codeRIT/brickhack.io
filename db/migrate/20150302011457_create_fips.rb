class CreateFips < ActiveRecord::Migration
  def change
    create_table :fips do |t|
      t.string :fips_code
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
