require 'spec_helper'

describe MuseekBindings::Parser do
  let(:instance) { MuseekBindings::Parser.new(schema) }
  let(:schema) { [] }

  describe '#parse' do
    subject { instance.parse(data) }

    context 'when data is blank' do
      let(:data) { '' }

      it { value(subject).must_be_empty }
    end

    context 'when data is not blank' do
      let(:data) { Support::FixtureLoader.('search') }
      # Schema is taken from SearchReply class
      let(:schema) do
        [
          { name: :ticket, type: :uint32 },
          { name: :user, type: :string },
          { name: :free, type: :boolean },
          { name: :speed, type: :uint32 },
          { name: :queue, type: :uint32 },
          { name: :results, type: [
             path: :string,
             size: :uint64,
             file_type: :string,
             attributes: [value: :uint32]
           ]
          }
        ]
      end

      it 'deserializes scalar values' do
        value(subject[:ticket]).must_be_kind_of Integer
        value(subject[:user]).must_be_kind_of String
      end

      it 'deserializes list values' do
        value(subject[:results]).must_be_kind_of Array
        value(subject[:results]).must_be_length_of 42

        value(subject[:results].first).must_have_keys(:path, :size, :file_type, :attributes)
      end
    end
  end
end
