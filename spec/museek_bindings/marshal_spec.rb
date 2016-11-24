require 'spec_helper'

describe MuseekBindings::Marshal do
  let(:instance) { MuseekBindings::Marshal.new(schema) }
  let(:schema) { [] }

  describe '#dump' do
    let(:obj) do
      klass = Struct.new(:name, :coolness) do
        def cool?
          coolness > 10
        end
      end

      klass.new('Billy Corgan', 42)
    end

    let(:schema) do
      [
        { name: :name, type: :string },
        { name: :coolness, type: :uint32 },
        { name: :cool?, type: :boolean }
      ]
    end

    subject { instance.dump(obj) }

    it 'is a string' do
      value(subject).must_be_kind_of String
    end

    it 'matches string data' do
      value(subject).must_match 'Billy Corgan'
    end

    it 'contains length as first 4 bytes' do
      expected_length = subject.unpack('l').first + 4

      value(subject).must_be_length_of expected_length
    end

    context 'when parsing value via MuseekBindings::Parser' do
      subject { parser.parse(data) }

      let(:data) { instance.dump(obj)[4..-1] }
      let(:parser) do
        MuseekBindings::Parser.new(
          [
            { name: :name, type: :string },
            { name: :coolness, type: :uint32 },
            { name: :cool, type: :boolean }
          ]
        )
      end

      it 'is parseable' do
        value(subject[:name]).must_equal 'Billy Corgan'
        value(subject[:coolness]).must_equal 42
        value(subject[:cool]).must_be_true
      end
    end
  end
end
