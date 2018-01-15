require 'test_helper'

module SecurityTxt
  class TestMiddleware < ActiveSupport::TestCase
    test 'middleware is pass through' do
      app = MiniTest::Mock.new
      mid = SecurityTxt::Middleware.new(app)
      app.expect :call, ['out'], [{}]
      assert_equal ['out'], mid.call({})
      app.verify
    end

    test 'middleware without config is passthrough' do
      app = MiniTest::Mock.new
      mid = SecurityTxt::Middleware.new(app)
      req = { 'PATH_INFO' => '/.well-known/security.txt' }
      app.expect :call, ['out'], [req]
      assert_equal ['out'], mid.call(req)
      app.verify
    end

    test 'middleware with config answers' do
      app = MiniTest::Mock.new
      mid = SecurityTxt::Middleware.new(app, :acknowledgment => 'foobar')
      req = { 'PATH_INFO' => '/.well-known/security.txt' }
      out = mid.call(req)
      assert_equal(["Acknowledgment: foobar\n"], out.body)
      assert_equal(200, out.status)
      assert_equal('text/plain', out.headers['Content-Type'])
      app.verify

      app = MiniTest::Mock.new
      mid = SecurityTxt::Middleware.new(app, (-> () { { :acknowledgment => 'barfoo' } }))
      req = { 'PATH_INFO' => '/.well-known/security.txt' }
      out = mid.call(req)
      assert_equal(["Acknowledgment: barfoo\n"], out.body)
      assert_equal(200, out.status)
      assert_equal('text/plain', out.headers['Content-Type'])
      app.verify
    end
  end
end
