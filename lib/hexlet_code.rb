# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Модуль HexletCode позволяет создавать html-формы
module HexletCode
  class Error < StandardError; end
  # Модуль HexletCode::Tag позволяет создавать простые тэги с указанием атрибутов
  module Tag
    def self.build(tag, **options, &block)
      join_options = options.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
      tag_options = [tag, join_options].join(' ').to_s.rstrip
      block_given? ? "<#{tag_options}>#{block.call}</#{tag}>" : "<#{tag_options}>"
    end
  end

  def self.initialize(user)
    @user = user
  end

  def self.form_for(user, **options, &block)
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
    input_builder = InputBuilder.new(user)
    "#{result}#{block.call(input_builder) if block_given?}</form>"
  end

  # Класс InputBuilder позволяет генерировать input-тэги с указанными атрибутами
  class InputBuilder
    def initialize(user)
      @user = user
      @fields = ''
    end

    def input(name, **options)
      value = @user.public_send(name)
      label = Tag.build('label', for: name) { name.capitalize }
      field_html = if options[:as] == :text
                     cols = options.fetch(:cols, 20)
                     rows = options.fetch(:rows, 40)
                     textarea_tag = Tag.build('textarea', name: name, cols: cols, rows: rows) { value }
                     "#{label}#{textarea_tag}"
                   else
                     join_options = options.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
                     input_tag = Tag.build('input', name: name, type: 'text', value: value).sub('>',
                                                                                                " #{join_options}>")
                     "#{label}#{input_tag}".gsub(/\s+>/, '>')
                   end
      @fields = "#{@fields}#{field_html}"
    end

    def submit(value = nil)
      submit_field = if value.nil?
                       Tag.build('input', type: 'submit', value: 'Save')
                     else
                       Tag.build('input', type: 'submit', value: value.to_s)
                     end
      @fields = "#{@fields}#{submit_field}"
    end
  end
end
