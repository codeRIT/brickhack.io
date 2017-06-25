class QuestionnaireDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_questionnaire_path, :manage_school_path, :current_user

  def view_columns
    @view_columns ||= {
      id: { source: 'Questionnaire.id', cond: :eq },
      first_name: { source: 'Questionnaire.first_name' },
      last_name: { source: 'Questionnaire.last_name' },
      email: { source: 'User.email' },
      admin: { source: 'User.admin', cond: :eq, searchable: false },
      acc_status: { source: 'Questionnaire.acc_status', searchable: false },
      checked_in: { source: 'Questionnaire.checked_in_at', searchable: false },
      school: { source: 'School.name' }
    }
  end

  private

  def data
    records.map do |record|
      {
        bulk: current_user.admin_limited_access ? '' : "<input type=\"checkbox\" data-bulk-row-edit=\"#{record.id}\">".html_safe,
        link: link_to('<i class="fa fa-search"></i>'.html_safe, manage_questionnaire_path(record)),
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,
        email: record.email,
        acc_status: "<span class=\"acc-status-#{record.acc_status}\">#{record.acc_status.titleize}</span>".html_safe,
        checked_in: record.checked_in? ? '<span class="acc-status-accepted">Yes</span>'.html_safe : 'No',
        school: link_to(record.school.name, manage_school_path(record.school))
      }
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    Questionnaire.includes(:user, :school).references(:user, :school)
  end
end
