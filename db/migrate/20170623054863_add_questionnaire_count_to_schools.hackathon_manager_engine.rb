# This migration comes from hackathon_manager_engine (originally 20150113233730)
class AddQuestionnaireCountToSchools < ActiveRecord::Migration[4.2]
  def up
    add_column :schools, :questionnaire_count, :int
    Questionnaire.select(:school_id).each do |q|
      School.increment_counter(:questionnaire_count, q.school_id)
    end
  end

  def down
    remove_column :schools, :questionnaire_count, :int
  end
end
