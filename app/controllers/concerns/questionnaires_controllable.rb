module QuestionnairesControllable
  extend ActiveSupport::Concern

  private

  def convert_school_name_to_id(questionnaire)
    if questionnaire[:school_name]
      school = School.where(name: questionnaire[:school_name]).first
      school = School.create(name: questionnaire[:school_name]) if school.blank?
      questionnaire[:school_id] = school.id
      questionnaire.delete :school_name
    end
    questionnaire
  end
end
