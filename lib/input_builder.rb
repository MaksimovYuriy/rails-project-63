# frozen_string_literal: true

# Класс InputBuilder позволяет генерировать input-тэги с указанными атрибутами
class InputBuilder
  def initialize(entity)
    @entity = entity
    @fields = []
  end

  def input(name, **options)
    label_hash_data = { tag_name: 'label', options: { for: name }, value: name.capitalize }
    @fields << label_hash_data
    input_hash_data = {}
    value = @entity.public_send(name)
    case options[:as]
    when :text
      options.delete(:as)
      input_hash_data[:tag_name] = 'textarea'
      input_hash_data[:options] = { name: name, cols: 20, rows: 40 }.merge(options)
      input_hash_data[:value] = value
    when nil
      input_hash_data[:tag_name] = 'input'
      input_hash_data[:options] = { name: name, type: 'text', value: value }.merge(options)
      input_hash_data[:value] = ''
    end
    @fields << input_hash_data
  end

  def submit(value = 'Save')
    submit_hash_data = { tag_name: 'input', options: { type: 'submit', value: value } }
    @fields << submit_hash_data
  end
end
