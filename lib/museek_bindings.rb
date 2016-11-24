require 'digest'
require 'forwardable'
require 'simple_enum'

module MuseekBindings
  autoload :Parser, 'museek_bindings/parser'
  autoload :Marshal, 'museek_bindings/marshal'
  autoload :BinUtils, 'museek_bindings/bin_utils'
  autoload :Message, 'museek_bindings/message'
  autoload :MessageMap, 'museek_bindings/message_map'
end
