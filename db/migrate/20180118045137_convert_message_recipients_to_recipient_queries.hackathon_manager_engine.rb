# This migration comes from hackathon_manager_engine (originally 20180118035548)
class ConvertMessageRecipientsToRecipientQueries < ActiveRecord::Migration[5.1]
  CONVERSION_MAPPING = {
    "bus-list-cornell-bing"            => ["bus-list", 1],
    "bus-list-buffalo"                 => ["bus-list", 2],
    "bus-list-albany"                  => ["bus-list", 3],
    "bus-list-cornell-bing-eligible"   => ["bus-list--eligible", 1],
    "bus-list-buffalo-eligible"        => ["bus-list--eligible", 2],
    "bus-list-albany-eligible"         => ["bus-list--eligible", 3],
    "bus-list-cornell-bing-applied"    => ["bus-list--applied", 1],
    "bus-list-buffalo-applied"         => ["bus-list--applied", 2],
    "bus-list-albany-applied"          => ["bus-list--applied", 3],
    "school-rit"                       => ["school", 2304],
    "school-cornell"                   => ["school", 2164],
    "school-binghamton"                => ["school", 5526],
    "school-buffalo"                   => ["school", 2345],
    "school-waterloo"                  => ["school", 5580],
    "school-toronto"                   => ["school", 5539],
    "school-umd-collegepark"           => ["school", 5543]
  }.freeze

  def up
    Message.all.each do |message|
      CONVERSION_MAPPING.to_a.each do |mapping|
        old = mapping[0]
        new_type = mapping[1][0]
        new_id = mapping[1][1]

        index = message.recipients.index(old)
        next if index.nil?

        message.recipients[index] = "#{new_type}::#{new_id}"
        message.save!
      end
    end
  end
end
