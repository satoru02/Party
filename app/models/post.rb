class Post < ApplicationRecord
  include Pager

  validates :title, presence: true, length: { maximum: 100 }
  belongs_to :user
  belongs_to :category
  has_one :room, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :entry_responses, dependent: :destroy
  acts_as_taggable_on :tags
end