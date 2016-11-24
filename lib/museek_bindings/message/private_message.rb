class MuseekBindings::Message::PrivateMessage < MuseekBindings::Message::Base
  CODE = 770

  field :_direction, type: :uint32
  field :timestamp, type: :uint32
  field :user, type: :string
  field :message, type: :string

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :user, type: :string
  dump_attr :message, type: :string

  as_enum(:direction, [:incomming, :outgoing], source: :_direction)
end
