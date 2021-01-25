class JoinedPostSerializer
  include JSONAPI::Serializer

  set_type :room
  attributes :id, :name, :host_id, :post_id

  attribute :host_user do |object|
    object.host_user
  end

  #fix
  attribute :joined_event do |object|
    @posts = []
    post = Post.find_by(id: object.post_id)
    category = Category.find_by(id: post.category_id)
    @posts.push(post: post, category: category.name)
    @posts
  end
end
