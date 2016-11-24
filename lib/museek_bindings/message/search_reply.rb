class MuseekBindings::Message::SearchReply < MuseekBindings::Message::Base
  CODE = 1026

  field :ticket, type: :uint32
  field :user, type: :string
  field :free, type: :boolean
  field :speed, type: :uint32
  field :queue, type: :uint32
  field :results, type: [
          path: :string,
          size: :uint64,
          file_type: :string,
          attributes: [value: :uint32]
        ]
end
