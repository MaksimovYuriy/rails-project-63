# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  User = Struct.new(:name, :job, keyword_init: true)
  
  module Tag
    def self.build(tag, **options, &block)
      join_options = options.map { |key, value| "#{key}=\"#{value}\""}.join(' ')
      tag_options = "#{[tag, join_options].join(' ')}".rstrip
      result = block_given? ? "<#{tag_options}>#{block.call}</#{tag}>" : "<#{tag_options}>"
      result
    end
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
    join_options.empty? ? "<form #{action_method_opts}></form>" : "<form #{action_method_opts} #{join_options}></form>"
  end

end