# frozen_string_literal: true

module HexletCode
  module Inputs
    # Класс для textarea
    class Text
      def initialize(field)
        @tag_name = 'textarea'
        @options = { name: field[:name], cols: 20, rows: 40 }.merge(field[:options])
        @value = field[:value]
      end

      def render
        Tag.build(@tag_name, **@options) { @value }
      end
    end
  end
end
