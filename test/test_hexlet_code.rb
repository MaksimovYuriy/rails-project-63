# frozen_string_literal: true

require "test_helper"
require_relative '../lib/hexlet_code'

require 'minitest/autorun'
require 'minitest/power_assert'

class TestHexletCode < Minitest::Test
  
  def test_form_without_options()
    user = HexletCode::User.new(name: 'Yura')

    result_string = HexletCode.form_for(user) do |f|
    end

    expected_string = "<form action=\"#\" method=\"post\"></form>"
    assert_equal(result_string, expected_string)
  end

  def test_form_with_class()
    user = HexletCode::User.new(name: 'Yura')

    result_string = HexletCode.form_for(user, class: 'hexlet-form') do |f|
    end

    expected_string = "<form action=\"#\" method=\"post\" class=\"hexlet-form\"></form>"
    assert_equal(result_string, expected_string)
  end

  def test_form_with_class_and_url()
    user = HexletCode::User.new(name: 'Yura')

    result_string = HexletCode.form_for(user, class: 'hexlet-form', url: '/profile') do |f|
    end
    
    expected_string = "<form action=\"/profile\" method=\"post\" class=\"hexlet-form\"></form>"
    assert_equal(result_string, expected_string)
  end
end
