# frozen_string_literal: true

# Класс InputBuilder позволяет генерировать input-тэги с указанными атрибутами
module HexletCode
  class InputBuilder
    attr_reader :fields

    def initialize(entity)
      @entity = entity
      @fields = []
    end

    def input(name, **options)
      label_ordered_data = { tag_name: 'label', options: { for: name }, value: name.capitalize }
      @fields << label_ordered_data
      input_ordered_data = {}
      value = @entity.public_send(name)
      case options[:as]
      when :text
        options.delete(:as)
        input_ordered_data[:tag_name] = 'textarea'
        input_ordered_data[:options] = { name: name, cols: 20, rows: 40 }.merge(options)
        input_ordered_data[:value] = value
      when nil
        input_ordered_data[:tag_name] = 'input'
        input_ordered_data[:options] = { name: name, type: 'text', value: value }.merge(options)
        input_ordered_data[:value] = ''
      end
      @fields << input_ordered_data
    end

    def submit(value = 'Save', **options)
      submit_ordered_data = { tag_name: 'input', options: { type: 'submit', value: value }.merge(options) }
      @fields << submit_ordered_data
    end
  end
end
