class SchoolDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_school_path

  def sortable_columns
    @sortable_columns ||= [
      'schools.id',
      'schools.name',
      'schools.city',
      'schools.state',
      'schools.questionnaire_count'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'schools.id',
      'schools.name',
      'schools.city',
      'schools.state',
      'schools.address'
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
        record.questionnaire_count
      ]
    end
  end

  def get_raw_records
    School.all
  end
end
