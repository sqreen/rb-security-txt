require 'test_helper'
require 'securitytxt/parser'

module SecurityTxt
  class TestParser < ActiveSupport::TestCase
    test 'Genereator class' do
      assert_kind_of(Class, SecurityTxt::Parser)
    end

    test 'empty' do
      assert_equal({}, Parser.new.parse(''))
    end

    test 'data simple' do
      a = { 'foo' => 'bar', 'bar' => 'foo' }
      assert_equal(a,
                   Parser.new.parse("Foo: bar\nBar: foo\n"))
    end
    test 'data multiple' do
      a = { 'foo' => %w[bar foo] }
      assert_equal(a,
                   Parser.new.parse("Foo: bar\nFoo: foo\n"))
    end
  end
end
