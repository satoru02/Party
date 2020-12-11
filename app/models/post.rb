class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true

  def customize_time
    I18n.l self.created_at, format: :short
  end
end
