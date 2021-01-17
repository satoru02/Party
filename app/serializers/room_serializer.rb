class RoomSerializer
  include JSONAPI::Serializer

  set_type :room
  attributes :id, :name, :host_id, :post_id, :resource_token
  has_many :users
  has_many :messages

  attribute :avatar_info do |object|
    @index_avatar = []
    object.users.each do |user|
      ActiveStorage::Current.host = "http://localhost:5000"
      @index_avatar.push(user_id: user.id, avatar: user.avatar.blob.service_url)
    end
    @index_avatar
  end

  attribute :message_info do |message, params|
    params[:messages]
  end

  attribute :user_info do |message, params|
    params[:users]
  end
end
