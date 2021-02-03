class PostSerializer
  include JSONAPI::Serializer

  set_type :post
  attributes :id, :title, :user_id, :category_id, :content, :created_at, :category, :tag_list, :tools
  has_many :entries

  attribute :can_request_entry do |post, params|
    post.entries.find_by(user_id: params[:user_id]).nil? ? true : false
  end
end
