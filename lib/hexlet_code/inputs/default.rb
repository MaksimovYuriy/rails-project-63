# frozen_string_literal: true

module HexletCode
  module Inputs
    # Класс для дефолтного input с типом text
    class Default
      def initialize(field)
        @tag_name = 'input'
        @options = { name: field[:name], type: 'text', value: field[:value] }.merge(field[:options])
        @value = field[:value]
      end

      def render
        Tag.build(@tag_name, **@options) { @value }
      end
    end
  end
end
