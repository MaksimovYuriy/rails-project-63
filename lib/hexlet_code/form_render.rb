# frozen_string_literal: true

# Namespace
module HexletCode
  autoload(:Tag, 'hexlet_code/tag')
  # Класс FormRender позволяет отрендерить форму в разметке html
  class FormRender
    def self.render_html(out_tag_name, out_tag_options, data = [])
      # data[0][:as_type] - Тип инпута
      # data[0][:options] - Параметры
      # data[0][:name] - Отдельное значение для имени внутри тэга
      # data[0][:value] - Значение для парных тэгов
      data_result = data.map do |field|
        label = render_label_html(field[:as_type], field[:name])
        tag = HexletCode::Inputs.const_get(field[:as_type].to_s.capitalize).new(field).render
        "#{label}#{tag}"
      end.join
      Tag.build(out_tag_name, **out_tag_options) { data_result }
    end

    def self.render_label_html(field_type, name)
      return '' if field_type == :submit

      Tag.build('label', for: name) do
        name.capitalize
      end
    end
  end
end
