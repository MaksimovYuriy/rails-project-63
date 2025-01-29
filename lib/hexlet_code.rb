# frozen_string_literal: true

require_relative 'hexlet_code/version'

require_relative 'InputBuilder'

# Модуль HexletCode позволяет создавать html-формы
module HexletCode
  # Модуль HexletCode::Tag позволяет создавать простые тэги с указанием атрибутов
  module Tag
    def self.build(tag, **options, &block)
      join_options = options.map { |key, value| " #{key}=\"#{value}\"" }.join('')
      tag_options = "#{tag}#{join_options}"
      block_given? ? "<#{tag_options}>#{block.call}</#{tag}>" : "<#{tag_options}>"
    end
  end

  def self.form_for(entity, **options, &block)
    options[:action] = options.delete(:url) || '#'
    options[:method] ||= 'post'
    sort_hash = { action: options.delete(:action), method: options.delete(:method) }.merge(options)
    input_builder = InputBuilder.new(entity)
    Tag.build('form', **sort_hash) { block.call(input_builder) if block_given? }
  end
end
