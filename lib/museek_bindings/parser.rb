# Parser class. Deserializes museek messages.
#
# @since 0.0.1
class MuseekBindings::Parser
  # @param schema [Array<Hash>] the message's schema.
  #   Each element is a hash, containing two keys:
  #   - name: (Symbol) the name of element
  #   - type: (:boolean, :uint32, :uint64, :string, Array<Hash>) the type of element.
  #     If you want to represent nested type, pass array, containing one hash. Keys are names
  #     of nested type, values are types, i.e. :boolean, :uint32 and so on.
  #
  # @since 0.0.1
  def initialize(schema = [])
    @_schema = schema
  end

  # Parse museek string
  # @example
  #   schema = [
  #     { name: :name, type: :string },
  #     {
  #       name: :userinfo, type: [
  #         country: :string,
  #         age: :uint32,
  #         contact: [phone: :string]
  #       ]
  #     }
  #   ]
  #
  #   hash = MuseekBindings::Parser.new(schema).parse(data)
  #   puts hash # { name: 'Billy Corgan', userinfo: { country: 'US', ... } }
  #
  # @param data [String] the string to parse.
  #
  # @return [Hash] the deserialized message according to +schema+
  #
  # @since 0.0.1
  def parse(data)
    return {} if data.blank?

    @_schema.each_with_object({}) do |rule, result|
      result[rule[:name]], data = process_data(rule[:type], data)
    end
  end

  private

  # Extract from +data+ one item of +type+
  #
  # @param type [Symbol, Array] type of data to be extracted.
  #   @see #initialize for type definition
  # @param data [String] string, containing data
  #
  # @return [Array] two element array: extracted data and the rest of +data+ string.
  #
  # @since 0.0.1
  # @api private
  def process_data(type, data)
    case type
    when :boolean
      MuseekBindings::BinUtils.unpack_boolean(data)
    when :uint32
      MuseekBindings::BinUtils.unpack_uint32(data)
    when :uint64
      MuseekBindings::BinUtils.unpack_uint64(data)
    when :string
      MuseekBindings::BinUtils.unpack_string(data)
    when Array
      process_array(type.first, data)
    end
  end

  # Process Array type
  #
  # @param typehash [Hash] @see #initialize for type definitions
  # @param data [String] string containing data
  #
  # @return [Array] two element array: extracted data array and the rest of +data+ string
  #
  # @since 0.0.1
  # @api private
  def process_array(typehash, data)
    count, data = MuseekBindings::BinUtils.unpack_uint32(data)

    processed_array = count.times.each_with_object([]) do |_, result|
      result << typehash.reduce({}) do |acc, (name, type)|
        value, data = process_data(type, data)

        acc[name] = value

        acc
      end
    end

    return processed_array, data
  end
end
