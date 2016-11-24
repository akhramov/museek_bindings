# Represents challenge.
#
# * Response attributes:
#   [version] Challenge version
#   [challenge] Challenge string.
#
# @see Login How to reply to challenge
class MuseekBindings::Message::Challenge < MuseekBindings::Message::Base
  CODE = 1

  field :version, type: :uint32
  field :challenge, type: :string
end
