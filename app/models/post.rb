class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true
  belongs_to :user
  belongs_to :category
  # before_validation :url_chack

  scope :pager, ->(page: 1, per: 10) {
    num = page.to_i.positive? ? page.to_i - 1 : 0
    limit(per).offset(per.to_i * num)
  }

  def import_time
    self.update! date: customize_time
  end

  def url_check
  end

  private
    def customize_time; self.created_at.strftime("%-m/%-d/%Y") end
end