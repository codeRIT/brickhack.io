# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

puts "Seeding school list..."

csv_text = File.read('db/schools.csv')
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  School.create(row.to_hash)
end
