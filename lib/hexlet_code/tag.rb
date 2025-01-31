# frozen_string_literal: true

# Tag - позволяет сгенерировать html-тэг
module HexletCode
  module Tag
    UNPAIRED = %w[br hr img link input].freeze

    def self.build(tag, **options, &block)
      join_options = options.map { |key, value| " #{key}=\"#{value}\"" }.join
      tag_options = "#{tag}#{join_options}"
      return "<#{tag_options}>" if UNPAIRED.include?(tag)

      "<#{tag_options}>#{block.call if block_given?}</#{tag}>"
    end
  end
end
