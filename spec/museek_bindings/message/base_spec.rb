describe MuseekBindings::Message::Base do
  let(:subclass) { Class.new(MuseekBindings::Message::Base, &subclass_block) }
  let(:instance) { subclass.new(**constructor_args) }
  let(:constructor_args) { Hash[] }
  let(:subclass_block) { -> () { } }

  describe '.field' do
    before { subclass.field(field_name, type: type) }
    subject { instance }

    context 'when defining a simple string field' do
      let(:field_name) { :first_name }
      let(:type) { :string }

      it 'defines a field' do
        value(subject).must_respond_to field_name
      end
    end

    context 'when defining a list attribute' do
      let(:field_name) { :user_info }
      let(:type) { [first_name: :string, speed: :uint32] }

      it 'defines a field' do
        value(subject).must_respond_to field_name
      end
    end
  end

  describe '.dump_attr' do
    before { subclass.dump_attr(:name, **kwargs) }
    subject { instance }

    context 'when default value supplied' do
      let(:kwargs) { Hash[type: :string, default: 'Billy Corgan'] }

      it 'defines a field' do
        value(subject).must_respond_to :name
      end

      context 'when value is not set' do
        it 'uses default value' do
          value(subject.name).must_equal 'Billy Corgan'
        end
      end

      context 'when value is set' do
        let(:constructor_args) { Hash[name: 'Scott McCarver'] }

        it 'uses supplied value' do
          value(subject.name).must_equal 'Scott McCarver'
        end
      end
    end
  end

  describe '.parser' do
    subject { subclass.parser }
    before { subclass.field(:name, type: :string) }

    it 'returns a parser' do
      value(subject).must_be_instance_of MuseekBindings::Parser
    end
  end

  describe '.marshal' do
    subject { subclass.marshal }
    before { subclass.field(:name, type: :string) }

    it 'returns a marshal' do
      value(subject).must_be_instance_of MuseekBindings::Marshal
    end
  end

  describe '#to_binary' do
    subject { instance.to_binary }

    let(:constructor_args) { Hash[user: 'Billy Corgan', awesomeness: 42] }

    before do
      subclass.dump_attr :user, type: :string
      subclass.dump_attr :awesomeness, type: :uint32
    end

    it 'calls dump method on marshal' do
      assert_send([subclass.marshal, :dump, instance])
    end

    it 'returns string' do
      value(subject).must_be_kind_of String
    end
  end

  describe '#to_h' do
    subject { instance.to_h }

    let(:subclass_block) do
      ->() { def cool?; true; end }
    end

    let(:constructor_args) { Hash[user: 'Billy Corgan', awesomeness: 42] }

    before do
      subclass.field :user, type: :string
      subclass.field :awesomeness, type: :uint32
    end

    it 'retrieves schema from class' do
      assert_send([subclass, :schema])
    end

    it 'returns hash' do
      value(subject).must_be_kind_of Hash
    end

    it 'includes attributes' do
      value(subject).must_have_keys :user, :awesomeness
      value(subject[:user]).must_equal 'Billy Corgan'
    end

    context 'when methods option passed' do
      subject { instance.to_h(methods: :cool?) }

      it "includes method's call result" do
        value(subject).must_include(:cool?)
        value(subject[:cool?]).must_be_true
      end
    end
  end
end
