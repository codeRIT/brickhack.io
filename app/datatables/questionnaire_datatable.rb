class QuestionnaireDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_questionnaire_path

  def sortable_columns
    @sortable_columns ||= [
      'Questionnaires.id',
      'Questionnaires.first_name',
      'Questionnaires.last_name',
      'Users.email',
      'Questionnaires.acc_status',
      'Questionnaires.state',
      'Questionnaires.year',
      'Questionnaires.experience',
      'Questionnaires.interest',
      'Schools.name'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'Questionnaires.ID',
      'Questionnaires.first_name',
      'Questionnaires.last_name',
      'Users.email',
      'Questionnaires.state',
      'Schools.name'
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
        "<span class=\"acc-status-#{record.acc_status}\">#{record.acc_status.titleize}</span>",
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
