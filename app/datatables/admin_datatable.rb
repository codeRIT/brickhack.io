class AdminDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_admin_path

  def view_columns
    @view_columns ||= {
      id: { source: 'User.id' },
      email: { source: 'User.email' },
      admin_limited_access: { source: 'User.admin_limited_access', searchable: false }
    }
  end

  private

  def data
    records.map do |record|
      {
        link: link_to('<i class="fa fa-search"></i>'.html_safe, manage_admin_path(record)),
        id: record.id,
        email: record.email,
        admin_limited_access: record.admin_limited_access ? 'Limited Access' : 'Full Access'
      }
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    User.where(admin: true)
  end
end
