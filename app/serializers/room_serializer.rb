class RoomSerializer
  include JSONAPI::Serializer

  set_type :room
  attributes :id, :name, :host_id, :post_id, :resource_token
  has_many :messages, serializer: MessageSerializer

  attribute :latest_message do |object|
    object.messages.last
  end

  attribute :latest_message_notification do |object|
    object.messages.last.notification
  end

  attribute :host_avatar do |room|
    if room.host_user.avatar.attached?
      room.host_user.avatar_url(room.host_user.avatar.blob)
    end
  end

  #fix
  attribute :message_info do |room, params|
    if params[:messages]
      messages = []
      params[:messages].each do |mg|
        message = { message: mg, avatar: if mg.user.avatar.attached?; mg.user.avatar_url(mg.user.avatar.blob) end }
        messages.push(message)
      end
      messages
    end
  end

  attribute :user_info do |room, params|
    params[:users]
  end
end
