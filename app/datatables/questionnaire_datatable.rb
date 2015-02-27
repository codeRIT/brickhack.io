class QuestionnaireDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_questionnaire_path

  def sortable_columns
    @sortable_columns ||= [
      false,
      false,
      'questionnaires.id',
      'questionnaires.first_name',
      'questionnaires.last_name',
      'users.email',
      'questionnaires.acc_status',
      'questionnaires.state',
      'questionnaires.year',
      'questionnaires.experience',
      'questionnaires.interest',
      'schools.name'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'questionnaires.ID',
      'questionnaires.first_name',
      'questionnaires.last_name',
      'users.email',
      'questionnaires.state',
      'schools.name'
    ]
  end

  private

  def data
    records.map do |record|
      [
        '<input type="checkbox" data-bulk-row-edit="' + record.id.to_s + '">',
        link_to('<i class="fa fa-search"></i>'.html_safe, manage_questionnaire_path(record)),
        record.id,
        record.first_name,
        record.last_name,
        record.email,
        record.acc_status,
        record.state,
        record.year,
        record.experience,
        record.interest,
        record.school.name
      ]
    end
  end

  def get_raw_records
    Questionnaire.includes(:user, :school)
  end
end
