# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Модуль HexletCode позволяет создавать html-формы
module HexletCode
  # Namespace для классов-инпутов
  module Inputs
    autoload :Text, 'hexlet_code/inputs/text'
    autoload :Submit, 'hexlet_code/inputs/submit'
    autoload :Default, 'hexlet_code/inputs/default'
  end

  autoload(:InputBuilder, 'hexlet_code/input_builder')
  autoload(:FormRender, 'hexlet_code/form_render')

  def self.form_for(entity, **options, &block)
    ordered_options = { action: options.fetch(:url, '#'), method: 'post' }.merge(options.except(:url))
    input_builder = HexletCode::InputBuilder.new(entity)
    block.call(input_builder) if block_given?
    data = input_builder.fields
    HexletCode::FormRender.render_html('form', ordered_options, data)
  end
end
