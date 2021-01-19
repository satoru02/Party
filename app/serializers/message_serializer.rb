class MessageSerializer
  include JSONAPI::Serializer

  set_type :message
  attributes :id, :content, :room_id, :user_id, :classification
  belongs_to :room

  # attribute :posted_time do |object|
  #   object.created_at.strftime("%H:%M(%-m/%-d/%Y)")
  # end
end
