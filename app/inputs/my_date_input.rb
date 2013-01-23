class MyDateInput < SimpleForm::Inputs::Base

  def input
    template.content_tag(:div, class: 'input-prepend') do
      template.content_tag(:span, template.icon_tag(:calendar), class: 'add-on') +
      @builder.input_field(attribute_name, as: :string, class: 'datepicker',
          data: {'date-language' => 'ru', 'date-format' => 'dd.mm.yyyy', 'date-weekstart' => 1,
                 'date-viewmode' => options[:viewmode] || 'days'})
    end.html_safe
  end

end