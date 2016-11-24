require 'spec_helper'

describe MuseekBindings::BinUtils do
  describe '.pack_boolean' do
    subject do
      MuseekBindings::BinUtils.method(:pack_boolean).curry
    end

    it 'converts value to integer' do
      value(subject[false].ord).must_equal 0
      value(subject[true].ord).must_equal 1
    end
  end

  describe '.pack_uint32' do
    subject do
      MuseekBindings::BinUtils.pack_uint32(424_242)
    end

    it 'converts value to 4-byte string' do
      value(subject).must_be_kind_of String
      value(subject).must_be_length_of 4
    end
  end

  describe '.pack_int32' do
    subject do
      MuseekBindings::BinUtils.pack_int32(424_242)
    end

    it 'converts value to 4-byte string' do
      value(subject).must_be_kind_of String
      value(subject).must_be_length_of 4
    end
  end

  describe '.pack_string' do
    subject do
      MuseekBindings::BinUtils.pack_string('Billy Corgan')
    end

    it 'returns string' do
      value(subject).must_be_kind_of String
    end

    it 'prepends string with its length' do
      value(subject.unpack('l').first).must_equal 'Billy Corgan'.length
      value(subject[4..-1]).must_equal 'Billy Corgan'
    end
  end

  describe '.unpack_boolean' do
    subject do
      MuseekBindings::BinUtils.unpack_boolean(str)
    end

    context 'when first char at string is zero' do
      let(:str) { "\0Scott McCarver" }

      it 'returns a false and the rest of string' do
        boolean, rest = subject

        value(boolean).wont_be_true
        value(rest).must_equal 'Scott McCarver'
      end
    end

    context 'when first char at string is non-zero' do
      let(:str) { "\1Scott McCarver" }

      it 'returns a false and the rest of string' do
        boolean, rest = subject

        value(boolean).must_be_true
        value(rest).must_equal 'Scott McCarver'
      end
    end
  end

  describe '.unpack_uint32' do
    subject do
      MuseekBindings::BinUtils.unpack_uint32("*\0\0\0Scott McCarver")
    end

    it 'extracts 4-byte integer from string' do
      number, rest = subject

      value(number).must_equal 42
      value(rest).must_equal 'Scott McCarver'
    end
  end

  describe '.unpack_uint64' do
    subject do
      MuseekBindings::BinUtils.unpack_uint64("*\0\0\0\0\0\0\0Scott McCarver")
    end

    it 'extracts 8-byte integer from string' do
      number, rest = subject

      value(number).must_equal 42
      value(rest).must_equal 'Scott McCarver'
    end
  end

  describe '.unpack_string' do
    subject do
      MuseekBindings::BinUtils.unpack_string("\16\0\0\0Scott McCarver")
    end

    it 'extracts string' do
      string, rest = subject

      value(string).must_equal 'Scott McCarver'
      value(rest).must_be_empty
    end
  end
end
