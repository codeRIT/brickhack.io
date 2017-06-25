class MessageDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :manage_message_path

  def view_columns
    @view_columns ||= {
      id: { source: "Message.id" },
      name: { source: "Message.name" },
      subject: { source: "Message.subject" }
    }
  end

  private

  def data
    records.map do |record|
      {
        link: link_to('<i class="fa fa-search"></i>'.html_safe, manage_message_path(record)),
        id: record.id,
        name: record.name,
        subject: record.subject,
        status: record.status.titleize
      }
    end
  end

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    Message.unscoped
  end
end
