# frozen_string_literal: true

module HexletCode
  module Inputs
    # Класс для input с типом submit
    class Submit
      def initialize(field)
        @tag_name = 'input'
        @options = { type: 'submit', value: field[:value] }.merge(field[:options])
        @value = nil
      end

      def render
        Tag.build(@tag_name, **@options) { @value }
      end
    end
  end
end
