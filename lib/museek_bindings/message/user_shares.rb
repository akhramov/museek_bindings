class MuseekBindings::Message::UserShares < MuseekBindings::Message::Base
  CODE = 517

  field :user, type: :string
  field :folders, type: [
          name: :string,
          files: [
            name: :string,
            size: :uint64,
            file_type: :string,
            attributes: [value: :uint32]
          ]
        ]

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :user, type: :string
end
