class UsersPostSerializer
  include JSONAPI::Serializer

  set_type :user_post
  attributes :id, :title, :user_id, :start_date, :end_date, :category_id, :content, :created_at, :category, :tag_list
end
