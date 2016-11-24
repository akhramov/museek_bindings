MuseekBindings::MessageMap = MuseekBindings::Message.constants.each_with_object({}) do |const, acc|
  next if const == :Base

  message = MuseekBindings::Message.const_get(const)
  acc[message.const_get(:CODE)] = message
end
