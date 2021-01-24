class UsersPostSerializer
  include JSONAPI::Serializer

  set_type :post
  attributes :id, :title, :date, :user_id, :category_id, :content, :created_at, :category, :tag_list
end
