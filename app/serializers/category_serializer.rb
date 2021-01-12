class CategorySerializer
  include JSONAPI::Serializer

  set_type :category
  attributes :id, :name, :description
  has_many :posts

  attribute :post_info do |category, params|
    params[:post]
  end
end
