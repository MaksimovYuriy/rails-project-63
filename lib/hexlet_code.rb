# frozen_string_literal: true

require_relative 'hexlet_code/version'

autoload(:InputBuilder, 'hexlet_code/input_builder')
autoload(:FormRender, 'hexlet_code/form_render')

# Модуль HexletCode позволяет создавать html-формы
module HexletCode
  def self.form_for(entity, **options, &block)
    ordered_options = {action: options.fetch(:url, "#"), method: "post"}.merge(options.except(:url))
    input_builder = InputBuilder.new(entity)
    block.call(input_builder) if block_given?
    data = input_builder.fields
    FormRender.render_html('form', ordered_options, data)
  end
end
