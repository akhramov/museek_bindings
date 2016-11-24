class MuseekBindings::Message::JoinRoom < MuseekBindings::Message::Base
  CODE = 771

  field :room, type: :string
  field :users, type: [
          name: :string,
          status: :uint32,
          average_speed: :uint32,
          downloads_number: :uint32,
          files: :uint32,
          dirs: :uint32,
          full: :boolean,
          country: :string
        ]

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :room, type: :string
  dump_attr :private, type: :boolean, default: false
end
