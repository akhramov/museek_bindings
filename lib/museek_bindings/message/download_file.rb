# Download given file.
#
# * Request attributes:
#   [user] User, who has the wanted file.
#   [path] Path to the file on user's file system.
#   [offset] Position in file. Set it to non-zero to download a part of file.
class MuseekBindings::Message::DownloadFile < MuseekBindings::Message::Base
  CODE = 1283

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :user, type: :string
  dump_attr :path, type: :string
  dump_attr :offset, type: :uint32, default: 0
end
