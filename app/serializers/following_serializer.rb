class FollowingSerializer
  include JSONAPI::Serializer

  set_type :following_users
  attributes :id, :name, :email, :role, :activated, :about, :web_url,
             :youtube_url, :facebook_url, :instagram_url, :filmarks_url,
             :username, :location, :activated_at

  attribute :avatar_url do |object|
    object.avatar_url(object.avatar.blob)
  end
end