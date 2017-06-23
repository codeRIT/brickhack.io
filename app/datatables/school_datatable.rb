class SchoolDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_school_path, :manage_bus_list_path

  def view_columns
    @view_columns ||= {
      id: { source: 'School.id', cond: :eq },
      name: { source: 'School.name' },
      city: { source: 'School.city' },
      state: { source: 'School.state' },
      questionnaire_count: { source: 'School.questionnaire_count', searchable: false }
    }
  end

  private

  def data
    records.map do |record|
      {
        link: link_to('<i class="fa fa-search"></i>'.html_safe, manage_school_path(record)),
        id: record.id,
        name: record.name,
        city: record.city,
        state: record.state,
        questionnaire_count: record.questionnaire_count,
        bus_list: record.bus_list ? link_to(record.bus_list.name, manage_bus_list_path(record.bus_list)) : ''
      }
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    School.all
  end
end
