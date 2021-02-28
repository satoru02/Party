class MessageSerializer
  include JSONAPI::Serializer

  set_type :message
  attributes :id, :content, :room_id, :user_id, :classification
  belongs_to :room

  attribute :user_avatar do |object|
    if object.user.avatar.attached?
      object.user.avatar_url(object.user.avatar.blob)
    end
  end
end
