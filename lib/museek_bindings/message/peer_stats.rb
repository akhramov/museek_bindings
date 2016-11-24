class MuseekBindings::Message::PeerStats < MuseekBindings::Message::Base
  CODE = 515

  field :user, type: :string
  field :average_speed, type: :uint32
  field :downloads_number, type: :uint32
  field :files, type: :uint32
  field :dirs, type: :uint32
  field :full, type: :boolean
  field :country, type: :string

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :user, type: :string
end
