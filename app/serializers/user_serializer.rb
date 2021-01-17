class UserSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  set_type :user
  attributes :id, :name, :email, :role, :activated, :about, :web_url, :youtube_url, :facebook_url, :instagram_url, :filmarks_url, :username, :location
  has_many :posts, if: Proc.new { |record| record.posts.any? }

  attribute :avatar_url do|object|
    variant = object.avatar.variant(resize: "454x454")
    object.avatar_url(variant.blob)
  end
end