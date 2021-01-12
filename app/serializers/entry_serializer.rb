class EntrySerializer
  include JSONAPI::Serializer

  set_type :entry
  attributes :id, :activated, :user_id, :post_id, :activated_at
  belongs_to :post
end
