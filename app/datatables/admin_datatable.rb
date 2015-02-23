class AdminDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_admin_path

  def sortable_columns
    @sortable_columns ||= [
      false,
      'users.id',
      'users.email',
      'users.admin_read_only'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'users.ID',
      'users.email'
    ]
  end

  private

  def data
    records.map do |record|
      [
        link_to('<i class="fa fa-search"></i>'.html_safe, manage_admin_path(record)),
        record.id,
        record.email,
        record.admin_read_only ? 'Read-only' : 'No'
      ]
    end
  end

  def get_raw_records
    User.where(admin: true)
  end
end
