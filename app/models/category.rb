class Category < ApplicationRecord
  include ActiveModel::Serializers::JSON
  include Scooper
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :posts
end
