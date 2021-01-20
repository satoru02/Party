class Post < ApplicationRecord
  include Pager

  validates :title, presence: true, length: { maximum: 100 }
  belongs_to :user
  belongs_to :category
  has_one :room
  has_many :entries
  has_many :entry_responses
  acts_as_taggable_on :tags

  def import_time
    self.update! date: customize_time
  end

  def url_check
  end

  private
    def customize_time; self.created_at.strftime("%-m/%-d/%Y") end
end