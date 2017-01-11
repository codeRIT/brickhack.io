class FormattedBooleanInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.check_box(attribute_name, options, checked_value, unchecked_value)
  end

  private

  def checked_value
    options.fetch(:checked_value, '1')
  end

  def unchecked_value
    options.fetch(:unchecked_value, '0')
  end

  def merge_wrapper_options(options, wrapper_options)
    if wrapper_options
      options.merge(wrapper_options) do |_, oldval, newval|
        oldval + Array(newval) if oldval.is_a?(Array)
      end
    else
      options
    end
  end
end
