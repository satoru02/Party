class Post < ApplicationRecord
  include Pager

  belongs_to :user
  belongs_to :category
  has_one :room, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :entry_responses, dependent: :destroy
  acts_as_taggable_on :tags

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :tools, presence: true
end