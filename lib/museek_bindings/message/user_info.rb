class MuseekBindings::Message::UserInfo < MuseekBindings::Message::Base
  CODE = 516

  field :user, type: :string
  field :info, type: :string
  field :image, type: :string
  field :uploads, type: :uint32
  field :queue, type: :uint32
  field :free, type: :boolean

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :user, type: :string
end
