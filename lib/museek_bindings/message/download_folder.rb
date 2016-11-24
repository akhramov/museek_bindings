# Download given folder.
#
# * Request attributes:
#   [user] User, owner of folder.
#   [path] Path to the folder
class MuseekBindings::Message::DownloadFolder < MuseekBindings::Message::Base
  CODE = 1284

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :user, type: :string
  dump_attr :path, type: :string
end
