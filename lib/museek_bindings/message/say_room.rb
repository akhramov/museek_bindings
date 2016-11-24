class MuseekBindings::Message::SayRoom < MuseekBindings::Message::Base
  CODE = 775

  field :room, type: :string
  field :user, type: :string
  field :message, type: :string

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :room, type: :string
  dump_attr :message, type: :string
end
