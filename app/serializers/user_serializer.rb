class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :name, :email, :role, :activated, :about, :web_url, :youtube_url, :facebook_url, :instagram_url, :filmarks_url, :username, :location
  has_many :posts, if: Proc.new { |record| record.posts.any? }
end
