# frozen_string_literal: true

require 'test_helper'
autoload(:HexletCode, '../lib/hexlet_code')

require 'minitest/autorun'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_form_without_options
    user = User.new(name: 'Yura')

    result_string = HexletCode.form_for(user)

    expected_string = '<form action="#" method="post"></form>'
    assert_equal(result_string, expected_string)
  end

  def test_form_with_class
    user = User.new(name: 'Yura')

    result_string = HexletCode.form_for(user, class: 'hexlet-form')

    expected_string = '<form action="#" method="post" class="hexlet-form"></form>'
    assert_equal(result_string, expected_string)
  end

  def test_form_with_class_and_url
    user = User.new(name: 'Yura')

    result_string = HexletCode.form_for(user, class: 'hexlet-form', url: '/profile')

    expected_string = '<form action="/profile" method="post" class="hexlet-form"></form>'
    assert_equal(result_string, expected_string)
  end

  def test_form_with_input1
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

    result_string = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job, as: :text
    end

    expected_string = File.read('test/fixtures/form_with_input1.html')
    assert_equal(result_string, expected_string)
  end

  def test_form_with_input2
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'

    result_string = HexletCode.form_for user, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    expected_string = File.read('test/fixtures/form_with_input2.html')

    assert_equal(result_string, expected_string)
  end

  def test_form_with_input3
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'

    result_string = HexletCode.form_for user do |f|
      f.input :job, as: :text
    end

    expected_string = File.read('test/fixtures/form_with_input3.html')

    assert_equal(result_string, expected_string)
  end

  def test_form_with_input4
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'

    result_string = HexletCode.form_for user, url: '#' do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end

    expected_string = File.read('test/fixtures/form_with_input4.html')

    assert_equal(result_string, expected_string)
  end

  def test_form_with_input_and_submit
    user = User.new job: 'hexlet'

    result_string = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end

    expected_string = File.read('test/fixtures/form_with_input_and_submit.html')

    assert_equal(result_string, expected_string)
  end
end
