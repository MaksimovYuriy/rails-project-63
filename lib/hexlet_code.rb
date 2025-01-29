# frozen_string_literal: true

require_relative 'hexlet_code/version'

require_relative 'input_builder'
require_relative 'hash_decoder'

# Модуль HexletCode позволяет создавать html-формы
module HexletCode
  # Модуль HexletCode::Tag позволяет создавать простые тэги с указанием атрибутов
  module Tag
    UNPAIRED = %w[br hr img link input].freeze

    def self.build(tag, **options, &block)
      join_options = options.map { |key, value| " #{key}=\"#{value}\"" }.join
      tag_options = "#{tag}#{join_options}"
      if UNPAIRED.include?(tag)
        "<#{tag_options}>"
      else
        "<#{tag_options}>#{block.call if block_given?}</#{tag}>"
      end
    end
  end

  def self.form_for(entity, **options, &block)
    options[:action] = options.delete(:url) || '#'
    options[:method] ||= 'post'
    sort_hash = { action: options.delete(:action), method: options.delete(:method) }.merge(options)
    input_builder = InputBuilder.new(entity)
    if block_given?
      data = block.call(input_builder)
      HashDecoder.decode_to_html('form', sort_hash, data)
    else
      HashDecoder.decode_to_html('form', sort_hash)
    end
  end
end
