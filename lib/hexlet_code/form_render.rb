# frozen_string_literal: true

autoload(:Tag, 'hexlet_code/tag')

# Класс HashDecoder позволяет декодировать хэш в удобный формат представления
class FormRender
  def self.render_html(out_tag_name, out_tag_options, data = [])

    # data[0][:tag_name] - Имя тэга
    # data[0][:options] - Параметры
    # data[0][:value] || nil - Значение для парных тэгов

    data_result = ''
    data.each do |field|
      tag = Tag.build(field[:tag_name], **field[:options]) { field[:value] }
      data_result = "#{data_result}#{tag}"
    end
    Tag.build(out_tag_name, **out_tag_options) { data_result }
  end
end
