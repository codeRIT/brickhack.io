class DeletableAttachmentInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    out = ''
    out << @builder.file_field(attribute_name, merged_input_options)
    if object.send("#{attribute_name}?")
      out << @builder.input("delete_#{attribute_name}", as: :boolean, label: "Remove?")
    end
    out.html_safe
  end
end
