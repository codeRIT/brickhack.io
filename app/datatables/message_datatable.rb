class MessageDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :manage_message_path

  def sortable_columns
    @sortable_columns ||= [
      'messages.id',
      'messages.name',
      'messages.subject'
    ]
  end

  def searchable_columns
    @searchable_columns ||= [
      'messages.id',
      'message.name',
      'messages.subject',
      'messages.recipients'
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
