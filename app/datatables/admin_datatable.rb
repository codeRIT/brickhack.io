class AdminDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_admin_path

  def sortable_columns
    @sortable_columns ||= [
      'users.id',
      'users.email',
      'users.admin_limited_access'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'users.id',
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
        record.admin_limited_access ? 'Limited Access' : 'Full Access'
      ]
    end
  end

  def get_raw_records
    User.where(admin: true)
  end
end
