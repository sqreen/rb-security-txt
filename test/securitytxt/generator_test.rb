require 'test_helper'

module SecurityTxt
  class TestGenerator < ActiveSupport::TestCase
    test 'Genereator class' do
      assert_kind_of(Class, SecurityTxt::Generator)
    end

    test 'empty' do
      assert_equal('', Generator.new.generate)
    end

    test 'data simple' do
      assert_equal("Foo: bar\nBar: foo\n",
                   Generator.new('foo' => 'bar', 'bar' => 'foo').generate)
    end
    test 'data multiple' do
      assert_equal("Foo: bar\nFoo: foo\n",
                   Generator.new('foo' => %w[bar foo]).generate)
    end
  end
end
