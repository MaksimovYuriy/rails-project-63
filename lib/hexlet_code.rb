# frozen_string_literal: true

require_relative 'hexlet_code/version'

require_relative 'InputBuilder'

# Модуль HexletCode позволяет создавать html-формы
module HexletCode
  # Модуль HexletCode::Tag позволяет создавать простые тэги с указанием атрибутов
  module Tag
    def self.build(tag, **options, &block)
      join_options = options.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
      tag_options = [tag, join_options].join(' ').to_s.rstrip
      block_given? ? "<#{tag_options}>#{block.call}</#{tag}>" : "<#{tag_options}>"
    end
  end

  def self.form_for(entity, **options, &block)
    action_method_opts = if options[:method].nil?
                           'method="post"'
                         else
                           "method=\"#{options[:method]}\""
                         end
    if options[:url].nil?
      action_method_opts = "action=\"#\" #{action_method_opts}"
    else
      action_method_opts = "action=\"#{options[:url]}\" #{action_method_opts}"
      options.delete(:url)
    end
    join_options = options.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
    result = join_options.empty? ? "<form #{action_method_opts}>" : "<form #{action_method_opts} #{join_options}>"
    input_builder = InputBuilder.new(entity)
    "#{result}#{block.call(input_builder) if block_given?}</form>"
  end
end
