# frozen_string_literal: true

require 'hexlet_code'
# Класс InputBuilder позволяет генерировать input-тэги с указанными атрибутами
class InputBuilder
  def initialize(user)
    @user = user
    @fields = []
  end

  def input(name, **options)
    value = @user.public_send(name)
    label = HexletCode::Tag.build('label', for: name) { name.capitalize }
    field_html = if options[:as] == :text
                   cols = options.fetch(:cols, 20)
                   rows = options.fetch(:rows, 40)
                   textarea_tag = HexletCode::Tag.build('textarea', name: name, cols: cols, rows: rows) { value }
                   "#{label}#{textarea_tag}"
                 else
                   join_options = options.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
                   input_tag = HexletCode::Tag.build('input', name: name, type: 'text', value: value).sub('>',
                                                                                                          " #{join_options}>")
                   "#{label}#{input_tag}".gsub(/\s+>/, '>')
                 end
    @fields << field_html
  end

  def submit(value = nil)
    submit_field = if value.nil?
                     HexletCode::Tag.build('input', type: 'submit', value: 'Save')
                   else
                     HexletCode::Tag.build('input', type: 'submit', value: value.to_s)
                   end
    @fields << submit_field
  end
end
