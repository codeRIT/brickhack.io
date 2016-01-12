class QuestionnaireDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_questionnaire_path

  def sortable_columns
    @sortable_columns ||= [
      'Questionnaire.id',
      'Questionnaire.first_name',
      'Questionnaire.last_name',
      'User.admin',
      'Questionnaire.acc_status',
      'Questionnaire.checked_in_at',
      'School.name'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'Questionnaire.id',
      'Questionnaire.first_name',
      'Questionnaire.last_name',
      'User.admin',
      'School.name'
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
        record.checked_in? ? '<span class="acc-status-accepted">Yes</span>' : 'No',
        record.school.name
      ]
    end
  end

  def get_raw_records
    Questionnaire.includes(:user, :school).references(:user, :school)
  end
end
