class SchoolSelectionInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    input_name = attribute_name.to_s.gsub(/_id/, '_name')
    value = options[:value] || @builder.object.send(attribute_name).blank? ? '' : @builder.object.school.name
    text_field_options = merged_input_options.merge(data: { school_picker: true }, name: "#{object_name}[#{input_name}]", value: value)
    template.text_field(input_name, value, text_field_options)
  end
end
