class MuseekBindings::Message::Search < MuseekBindings::Message::Base
  CODE = 1025

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :type, type: :uint32, default: 0 # global search
  dump_attr :query, type: :string
end
