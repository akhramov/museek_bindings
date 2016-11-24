class MuseekBindings::Message::Login < MuseekBindings::Message::Base
  CODE = 2

  field :success, type: :boolean
  field :message, type: :string
  field :challenge, type: :string

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :algorithm, type: :string, default: 'SHA256'
  dump_attr :challenge_response, type: :string
  dump_attr :mask, type: :uint32, default: 255

  # Generate challenge response
  #
  # @return [String] hexdigest of challenge concatenated with interface password
  #
  # @since 0.0.1
  def challenge_response
    @challenge_response ||= Digest::SHA256.hexdigest(@challenge + @password)
  end
end
