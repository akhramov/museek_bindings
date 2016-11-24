# Binary utils.
#
# @since 0.0.1
# @api private
module MuseekBindings::BinUtils
  module_function

  # Extract a boolean from +str+.
  #   Boolean is 1-byte character. If it is not zero, it is true-ish.
  #
  # @param str [String]
  #
  # @return [Array] array of two elements: result and the rest of +str+.
  #
  # @since 0.0.1
  # @api private
  def unpack_boolean(str)
    [str[0].ord > 0, str[1..-1]]
  end

  # Extract an unsigned 4-byte integer from +str+.
  #
  # @param str [String]
  #
  # @return [Array] array of two elements: result and the rest of +str+.
  #
  # @since 0.0.1
  # @api private
  def unpack_uint32(str)
    [str.unpack('L').first, str[4..-1]]
  end

  # Extract an unsigned 8-byte integer from +str+.
  #
  # @param str [String]
  #
  # @return [Array] array of two elements: result and the rest of +str+.
  #
  # @since 0.0.1
  # @api private
  def unpack_uint64(str)
    [str.unpack('Q').first, str[8..-1]]
  end

  # Extract a string from +str+.
  #   Museek stores string as 4-byte length plus data.
  #
  # @param str [String]
  #
  # @return [Array] array of two elements: result and the rest of +str+.
  #
  # @since 0.0.1
  # @api private
  def unpack_string(str)
    length, message = unpack_uint32(str)

    [message[0...length], message[length..-1]]
  end

  # Converts +bool+ to number.
  #
  # @param bool [Boolean]
  #
  # @return [String] zero-char if false, one otherwise
  #
  # @since 0.0.1
  # @api private
  def pack_boolean(bool)
    [bool ? 1 : 0].pack('C')
  end

  # Converts +num+ to string.
  #
  # @param num [Integer]
  #
  # @return [String] unsigned 4-byte integer packed into string.
  #
  # @since 0.0.1
  # @api private
  def pack_uint32(num)
    [num].pack('L')
  end

  # Converts +num+ to string.
  #
  # @param num [Integer]
  #
  # @return [String] signed 4-byte integer packed into string.
  #
  # @since 0.0.1
  # @api private
  def pack_int32(num)
    [num].pack('l')
  end

  # Prepends +str+ with its length
  #
  # @param str [String]
  #
  # @return [String]
  #
  # @since 0.0.1
  # @api private
  def pack_string(str)
    pack_int32(str.length) + str
  end
end
