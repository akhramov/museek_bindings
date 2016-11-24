class MuseekBindings::Message::LeaveRoom < MuseekBindings::Message::Base
  CODE = 772

  field :room, type: :string

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :room, type: :string
end
