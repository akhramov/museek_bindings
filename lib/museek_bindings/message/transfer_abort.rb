# Aborts given transfer.
#
# * Request attributes:
#   [upload] Whether aborted transfer is upload.
#   [user] User, who owns the file.
#   [path] Path to the file on user's file system.
#
# * Response attributes:
#   [upload] Is transfer upload?
#   [user] User, who owns the file.
#   [path] Path to the file on user's file system.
class MuseekBindings::Message::TransferAbort < MuseekBindings::Message::Base
  CODE = 1285

  field :upload, type: :boolean
  field :user, type: :string
  field :path, type: :string

  dump_attr :code, type: :uint32, default: CODE
  dump_attr :upload, type: :boolean
  dump_attr :user, type: :string
  dump_attr :path, type: :string
end
