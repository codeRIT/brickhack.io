class MessageDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_message_path

  def sortable_columns
    @sortable_columns ||= [
      'Messages.id',
      'Messages.name',
      'Messages.subject'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'Messages.ID',
      'Message.name',
      'Messages.subject',
      'Messages.recipients'
    ]
  end

  private

  def data
    records.map do |record|
      [
        link_to('<i class="fa fa-search"></i>'.html_safe, manage_message_path(record)),
        record.id,
        record.name,
        record.subject,
        record.status.titleize
      ]
    end
  end

  def get_raw_records
    Message.unscoped
  end
end
