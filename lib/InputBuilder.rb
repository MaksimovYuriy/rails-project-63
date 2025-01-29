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
                   options.delete(:as)
                   textarea_tag = HexletCode::Tag.build('textarea', **({name: name, cols: 20, rows: 40}.merge(options))) { value }
                   "#{label}#{textarea_tag}"
                 else
                   input_tag = HexletCode::Tag.build('input', **({name: name, type: 'text', value: value}.merge(options)))
                   "#{label}#{input_tag}"
                 end
    @fields << field_html
  end

  def submit(value = 'Save')
    submit_field = HexletCode::Tag.build('input', type: 'submit', value: value.to_s)
    @fields << submit_field
  end
end
