# This migration comes from hackathon_manager_engine (originally 20180116022530)
class SetDefaultCountOnSchools < ActiveRecord::Migration[5.1]
  def up
    change_column :schools, :questionnaire_count, :int, default: 0
    School.where(questionnaire_count: nil).each do |record|
      record.questionnaire_count = 0
      record.save
    end
  end

  def down
    change_column :schools, :questionnaire_count, :int, default: nil
    School.where(questionnaire_count: 0).each do |record|
      record.questionnaire_count = nil
      record.save
    end
  end
end
