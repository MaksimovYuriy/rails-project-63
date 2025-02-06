# frozen_string_literal: true

# Namespace
module HexletCode
  # Класс InputBuilder позволяет генерировать input-тэги с указанными атрибутами
  class InputBuilder
    attr_reader :fields

    def initialize(entity)
      @entity = entity
      @fields = []
    end

    def input(name, **options)
      input_ordered_data = {}
      value = @entity.public_send(name)
      input_ordered_data[:as_type] = options[:as]
      input_ordered_data[:options] = options.except(:as)
      input_ordered_data[:name] = name
      input_ordered_data[:value] = value
      @fields << input_ordered_data
    end

    def submit(value = 'Save', **options)
      submit_ordered_data = {
        value: value,
        options: options,
        as_type: :submit
      }
      @fields << submit_ordered_data
    end
  end
end
