# Get transfer info.
#
# * Response attributes:
#   [upload] Whether transfer is upload.
#   [user] User, who owns the file.
#   [path] Path to the file on user's file system.
#   [place] Position in queue.
#   [state] Transfer state.
#   [error] Error description.
#   [progress] How many downloaded.
#   [filesize] Size of file.
#   [rate] Speed of transfer.
class MuseekBindings::Message::Transfer < MuseekBindings::Message::Base
  CODE = 1281

  field :upload, type: :boolean
  field :user, type: :string
  field :path, type: :string
  field :place, type: :uint32
  field :_state, type: :uint32
  field :error, type: :string
  field :progress, type: :uint64
  field :filesize, type: :uint64
  field :rate, type: :uint32

  as_enum(:state,
          [
            :finished,
            :transferring,
            :negotiating,
            :waiting,
            :establishing,
            :initiating,
            :connecting,
            :queued,
            :aquiring_address,
            :user_offline,
            :aborted_by_user,
            :connection_failure,
            :aborted,
            :remote_error,
            :local_error,
            :queued
          ],
          source: :_state)
end
