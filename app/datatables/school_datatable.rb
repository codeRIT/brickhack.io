class SchoolDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_school_path, :manage_bus_list_path

  def sortable_columns
    @sortable_columns ||= [
      'School.id',
      'School.name',
      'School.city',
      'School.state',
      'School.questionnaire_count'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'School.id',
      'School.name',
      'School.city',
      'School.state',
      'School.address'
    ]
  end

  private

  def data
    records.map do |record|
      [
        link_to('<i class="fa fa-search"></i>'.html_safe, manage_school_path(record)),
        record.id,
        record.name,
        record.city,
        record.state,
        record.questionnaire_count,
        record.bus_list ? link_to(record.bus_list.name, manage_bus_list_path(record.bus_list)) : ''
      ]
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    School.all
  end
end
