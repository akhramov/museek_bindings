# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'museek_bindings/version'

Gem::Specification.new do |spec|
  spec.name          = 'museek_bindings'
  spec.version       = MuseekBindings::VERSION
  spec.authors       = ['Artem Khramov']
  spec.email         = ['futu.fata@gmail.com']

  spec.summary       = %q{Museekd client bindigns for Ruby}
  spec.description   = %q{Parse and dump museekd objects easily}
  spec.homepage      = 'https://github.com/akhramov/'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'simple_enum', '~> 2.3.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
end
