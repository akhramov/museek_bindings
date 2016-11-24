class MuseekBindings::Message::RoomList < MuseekBindings::Message::Base
  CODE = 769

  field :list, type: [name: :string, usercount: :uint32]
  dump_attr :code, type: :uint32, default: CODE
end
