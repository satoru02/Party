class PostSerializer
  include JSONAPI::Serializer

  set_type :post
  attributes :id, :title, :date, :user_id, :category_id, :content
  has_many :entries

  attribute :can_request_entry do |post, params|
    post.entries.find_by(params[:user_id]).nil? ? true : false
  end
end
