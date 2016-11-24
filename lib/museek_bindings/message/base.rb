# coding: utf-8
# frozen_string_literal: true

# Base class for all kinds of Museek protocol messages.
#
# @since 0.0.1
class MuseekBindings::Message::Base
  extend SimpleEnum::Attribute
  extend Forwardable

  # @!method parse
  #   Parse binary data
  #
  #   @see MuseekBindings::Parser#parse
  #   @api private
  delegate parse: :'self.class.parser'

  # @!method dump
  #   Convert object to binary format
  #
  #   @see MuseekBindings::Marshal#dump
  #   @api private
  delegate dump: :'self.class.marshal'

  private :parse, :dump

  class << self
    # Defines museekd field, used in parsing.
    #
    # @example Define a string field
    #  field :name, type: :string
    #
    # @example Define an array field named files, containing entries with name and size attributes.
    #  field :files, type: [name: :string, size: uint32]
    #
    # @param name [Symbol] the name of field
    # @param type [Symbol, Array<Hash>] type of a field.
    #   - If passed value is a Symbol, possible values are :boolean, :uint32, :uint64, :string.
    #   - If passed value is an Array, it should contain a hash. Keys are names, values are types.
    #
    # @return [void]
    #
    # @note You should define attributes in order they appear in service response.
    # @since 0.0.1
    def field(name, type:)
      @_schema ||= []

      @_schema << { name: name, type: type }

      define_getter(name, type)
    end

    # Defines a dump attribute – an attribute, which will be used during binary conversion
    #
    # @example Define a string dump attribute
    #   class User < MuseekBindings::Message::Base
    #     dump_attr :name
    #   end
    #
    #   user = User.new(name: 'Billy Corgan')
    #   user.to_binary #=> "\x10\x00\x00\x00\f\x00\x00\x00Billy Corgan"
    #
    # @example Define an attribute with default value
    #   dump_attr :name, default: 'Billy Corgan'
    #
    # @param name [Symbol] the attribute's name
    # @param type [Symbol] the attribute's type. Any of :boolean, :uint32, :string
    # @param default [Boolean, Integer, String] the default value for attribute.
    #
    # @return [void]
    #
    # @note You should define attributes in order they will be sent back to the server
    # @since 0.0.1
    def dump_attr(name, type:, default: nil)
      @_dump_attributes ||= []

      @_dump_attributes << { name: name, type: type }

      define_getter(name, type, default)
    end

    # Get a parser for current class
    #
    # @example Parse server response
    #   class User < MuseekBindings::Message::Base
    #     field :name, type: :string
    #   end
    #
    #   data = "\x10\x00\x00\x00Billy Corgan"
    #   User.parser.parse(data) # => { name: "Billy Corgan" }
    #
    # @return [MuseekBindings::Parser] the parser for current class
    #
    # @see .field how to define parser attributes
    # @since 0.0.1
    def parser
      @_parser ||= MuseekBindings::Parser.new(@_schema)
    end

    # Get a marshaller for current class
    #
    # @return [MuseekBindings::Marshal] the parser for current class
    #
    # @see .dump_attribute how to define marshaller's attributes
    # @since 0.0.1
    def marshal
      @_marshal ||= MuseekBindings::Marshal.new(@_dump_attributes)
    end

    private

    # Define a getter for given attribute.
    #  also defines a getter with question mark for boolean attribute
    #
    # @param name [Symbol] the name of attribute
    # @param type [Symbol] the type of attribute
    # @param default [String, Integer, Boolean] the default value for attribute.
    #
    # @since 0.0.1
    # @api private
    def define_getter(name, type, default = nil)
      getter = ->() { instance_variable_get("@#{name}") || default }

      define_method("#{name}?", &getter) if type == :boolean
      define_method(name, &getter)
    end
  end

  # @param data [String] binary data to be parsed
  # @param attributes [Hash{Symbol => Integer, Boolean, String}] the object's attributes
  def initialize(data: nil, **attributes)
    init_attributes(**parse(data), **attributes)
  end

  # Convert object to binary format
  #
  # @example Convert object to binary format
  #   class User < MuseekBindings::Message::Base
  #     dump_attr :name, type: :string
  #     dump_attr :age, type: :uint32
  #   end
  #
  #   User.new(name: 'Silly me', age: 23).to_binary
  #
  # @return [String] binary representation suitable for museekd daemon
  #
  # @since 0.0.1
  def to_binary
    dump(self)
  end

  private

  # Sets instance variables
  #
  # @param data [Hash{Symbol => Integer, Boolean, String}] instance variables to be set
  #
  # @since 0.0.1
  # @api private
  def init_attributes(data)
    data.each do |(name, value)|
      instance_variable_set("@#{name}", value)
    end
  end
end
