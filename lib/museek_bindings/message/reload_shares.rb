class MuseekBindings::Message::ReloadShares < MuseekBindings::Message::Base
  CODE = 1795

  dump_attr :code, type: :uint32, default: CODE
end
