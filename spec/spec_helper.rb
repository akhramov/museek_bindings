require 'minitest/autorun'
require 'museek_bindings'
require 'support/fixture_loader'
require 'support/expectations'

MiniTest::Expectation.class_eval do
  include Support::Expectations
end

alias context describe
