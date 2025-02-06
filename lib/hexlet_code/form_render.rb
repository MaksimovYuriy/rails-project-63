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
      data_result = ''
      data.each do |field|
        label = render_label_html(field[:as_type], field[:name])
        ordered_options = order_options(field[:as_type], field[:name], field[:value], **field[:options])
        tag = Tag.build(name_by_type(field[:as_type]), **ordered_options) { field[:value] }
        data_result = "#{data_result}#{label}#{tag}"
      end
      Tag.build(out_tag_name, **out_tag_options) { data_result }
    end

    def self.order_options(as_type, name, value, **options)
      case as_type
      when :text
        { name: name, cols: 20, rows: 40 }.merge(options)
      when :submit
        { type: as_type.to_s, value: value }.merge(options)
      when nil
        { name: name, type: 'text', value: value }.merge(options)
      end
    end

    def self.name_by_type(as_type)
      case as_type
      when nil, :submit
        'input'
      when :text
        'textarea'
      end
    end

    def self.render_label_html(field_type, name)
      return '' if field_type == :submit

      Tag.build('label', for: name) do
        name.capitalize
      end
    end
  end
end
