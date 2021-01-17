class RoomSerializer
  include JSONAPI::Serializer

  set_type :room
  attributes :id, :name, :host_id, :post_id, :resource_token
  has_many :users
  has_many :messages

  # attribute :avatar_info do |object|
  #   object.users.each do |user|
  #     binding.pry
  #     avatar = user.avatar_url(user.avatar.blob)
  #     "#{avatar}"
  #   end
  # end

  attribute :message_info do |message, params|
    params[:messages]
  end

  attribute :user_info do |message, params|
    params[:users]
  end
end
