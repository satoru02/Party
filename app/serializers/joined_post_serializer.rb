class JoinedPostSerializer
  include JSONAPI::Serializer

  set_type :joined_post
  attributes :id, :title, :user_id, :start_date, :end_date, :category_id, :content, :created_at, :category, :tag_list

  attribute :host_user do |object|
    object.user
  end
end
