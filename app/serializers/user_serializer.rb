class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  has_many :posts, serializer: UsersPostSerializer
  attributes :id, :name, :email, :role, :activated, :about, :web_url,
             :youtube_url, :facebook_url, :instagram_url, :filmarks_url,
             :username, :location, :activated_at

  attribute :following do |object|
    object.following.map(&:id)
  end

  attribute :follower do |object|
    object.followers.map(&:id)
  end

  attribute :avatar_url do |object|
    object.avatar_url(object.avatar.blob)
  end
end

