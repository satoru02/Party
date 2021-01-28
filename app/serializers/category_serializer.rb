class CategorySerializer
  include JSONAPI::Serializer

  set_type :category
  attributes :id, :name, :description, :slug
  has_many :posts

end
