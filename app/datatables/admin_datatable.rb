class AdminDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :edit_manage_admin_path, :manage_admin_path

  def sortable_columns
    @sortable_columns ||= [
      false,
      'users.id',
      'users.email'
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
        link_to('<i class="fa fa-pencil"></i>'.html_safe, edit_manage_admin_path(record)),
        record.id,
        record.email
      ]
    end
  end

  def get_raw_records
    User.where(admin: true)
  end
end
