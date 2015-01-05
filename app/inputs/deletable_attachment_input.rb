class DeletableAttachmentInput < SimpleForm::Inputs::FileInput
  def input
    out = ''
    out << @builder.file_field(attribute_name, input_html_options)
    if object.send("#{attribute_name}?")
      out << @builder.input("delete_#{attribute_name}", as: :boolean, label: "Remove?")
    end
    out.html_safe
  end
end
