# Marshal class. Serializes objects to museek format.
#
# @since 0.0.1
class MuseekBindings::Marshal
  # @param schema [Array<Hash>] serialization metadata.
  #   Each element is a hash, containing two keys:
  #   - name: (Symbol) the name of accessor
  #   - type: (:boolean, :uint32, :string) the type of element
  #
  # @since 0.0.1
  def initialize(schema = [])
    @_schema = schema
  end

  # Serialize +obj+
  # @example
  #   marshal = MuseekBindings::Marshal.new([
  #     { name: :name, type: :string },
  #     { name: :awesomeness, type: :uint32 },
  #     { name: :cool?, type: :boolean }
  #   ])
  #
  #   class Musician < Struct.new(:name, :awesomeness)
  #     def cool?
  #       name == 'Billy Corgan'
  #     end
  #   end
  #
  # corgan = Musician.new('Billy Corgan', 42)
  #
  # marshal.dump(corgan) # => "\x15\x00\x00\x00\f\x00\x00\x00Billy Corgan*\x00\x00\x00\x01"
  #
  # @param obj [Object] object to be serialized
  # @return [String] serialized +object+
  #
  # @note this method prepends result with its length.
  # @since 0.0.1
  def dump(obj)
    result = @_schema.each_with_object('') do |rule, result|
      result << process_data(rule[:type], obj.public_send(rule[:name]))
    end

    MuseekBindings::BinUtils.pack_uint32(result.length) << result
  end

  private

  # Packs +data+ to string according to +type+
  #
  # @param type [:boolean, :uint32, :string] data type
  # @param data [Boolean, Integer, String] obj to be serialized
  #
  # @api private
  # @since 0.0.1
  def process_data(type, data)
    case type
    when :boolean
      MuseekBindings::BinUtils.pack_boolean(data)
    when :uint32
      MuseekBindings::BinUtils.pack_uint32(data)
    when :string
      MuseekBindings::BinUtils.pack_string(data)
    end
  end
end
