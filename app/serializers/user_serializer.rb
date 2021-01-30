class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  has_many :posts, serializer: UsersPostSerializer
  attributes :id, :name, :email, :role, :activated, :about, :web_url,
             :youtube_url, :facebook_url, :instagram_url, :filmarks_url,
             :username, :location, :activated_at
  # attribute :avatar_url do |object|
  #   variant = object.avatar.variant(resize: "454x454")
  #   object.avatar_url(variant.blob)
  # end
end