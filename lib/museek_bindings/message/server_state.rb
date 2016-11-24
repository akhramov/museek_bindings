class MuseekBindings::Message::ServerState < MuseekBindings::Message::Base
  CODE = 3

  field :running, type: :boolean
  field :username, type: :string
end
