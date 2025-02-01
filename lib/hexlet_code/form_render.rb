# frozen_string_literal: true

# Namespace
module HexletCode
  autoload(:Tag, 'hexlet_code/tag')

  # Класс FormRender позволяет отрендерить форму в разметке html
  class FormRender
    def self.render_html(out_tag_name, out_tag_options, data = [])
      # data[0][:tag_name] - Имя тэга
      # data[0][:options] - Параметры
      # data[0][:value] || nil - Значение для парных тэгов
      data_result = ''
      data.each do |field|
        label = render_label_html(field[:options][:type], field[:options][:name])
        ordered_options = order_options(field[:tag_name], **field[:options])
        tag = Tag.build(field[:tag_name], **ordered_options) { field[:value] }
        data_result = "#{data_result}#{label}#{tag}"
      end
      Tag.build(out_tag_name, **out_tag_options) { data_result }
    end

    def self.order_options(tag_name, **options)
      return options if tag_name == 'input'

      { name: options.fetch(:name), cols: 20, rows: 40 }.merge(options.except(:name))
    end

    def self.render_label_html(field_type, name)
      return '' if field_type == 'submit'

      Tag.build('label', for: name) do
        name.capitalize
      end
    end
  end
end
