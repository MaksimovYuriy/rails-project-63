# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end
  
  class Tag

    def self.build(tag, **options, &block)

      join_options = options.map { |key, value| "#{key}=\"#{value}\""}.join(' ')
      tag_options = "#{[tag, join_options].join(' ')}".rstrip
      result = block_given? ? "<#{tag_options}>#{block.call}</#{tag}>" : "<#{tag_options}>"
      result

    end

  end

end