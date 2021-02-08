class MessageSerializer
  include JSONAPI::Serializer

  set_type :message
  attributes :id, :content, :room_id, :user_id, :classification
  belongs_to :room
end
