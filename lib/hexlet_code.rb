# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end
  
  module Tag
    def self.build(tag, **options, &block)
      join_options = options.map { |key, value| "#{key}=\"#{value}\""}.join(' ')
      tag_options = "#{[tag, join_options].join(' ')}".rstrip
      result = block_given? ? "<#{tag_options}>#{block.call}</#{tag}>" : "<#{tag_options}>"
      result
    end
  end

  def self.initialize(user)
    @user = user
  end

  def self.form_for(user, **options, &block)

    action_method_opts = "method=\"post\""
    if options[:url].nil?
      action_method_opts = "action=\"#\" #{action_method_opts}"
    else
      action_method_opts = "action=\"#{options[:url]}\" #{action_method_opts}"
      options.delete(:url)
    end
    join_options = options.map { |key, value| "#{key}=\"#{value}\""}.join(' ')
    result = join_options.empty? ? "<form #{action_method_opts}>" : "<form #{action_method_opts} #{join_options}>"
    
    input_builder = InputBuilder.new(user)
    "#{result}#{block.call(input_builder) if block_given?}</form>"
  end

  class InputBuilder

    def initialize(user)
      @user = user
      @fields = ""
    end

    def input(name, **options)
      value = @user.public_send(name)

      field_html = if options[:as] == :text
        cols = options.fetch(:cols, 20)
        rows = options.fetch(:rows, 40)
        "<textarea name=\"#{name}\" cols=\"#{cols}\" rows=\"#{rows}\">#{value}</textarea>"
      else
        join_options = options.map { |key, value| "#{key}=\"#{value}\""}.join(' ')
        "<input name=\"#{name}\" type=\"text\" value=\"#{value}\" #{join_options}>".gsub(/\s+>/, '>')
      end

      @fields = "#{@fields}#{field_html}"
    end

  end
end

