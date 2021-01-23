class UserSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  set_type :user
  has_many :posts
  attributes :id, :name, :email, :role, :activated, :about, :web_url,
             :youtube_url, :facebook_url, :instagram_url, :filmarks_url,
             :username, :location, :activated_at

  attribute :joined_event do |object|
    @posts = []
    object.rooms.each do |room|
      post = Post.find_by(id: room.post_id)
      category = Category.find_by(id: post.category_id)
      @posts.push(post: post, category: category.name)
    end
    @posts
  end

  attribute :avatar_url do|object|
    variant = object.avatar.variant(resize: "454x454")
    object.avatar_url(variant.blob)
  end
end