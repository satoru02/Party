class PostSerializer
  include JSONAPI::Serializer

  set_type :post
  attributes :id, :title, :user_id, :start_date, :end_date, :category_id, :content, :created_at, :category, :tag_list, :tools, :user
  has_many :entries

  attribute :can_request_entry do |post, params|
    post.entries.find_by(user_id: params[:user_id]).nil? ? true : false
  end

  attribute :user_avatar do |post|
    if post.user.avatar.attached?
      post.user.avatar_url(post.user.avatar.blob)
    end
  end
end
