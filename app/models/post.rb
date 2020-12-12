class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true

  # callback処理でなく、現在はhttpリクエスト時に使っている。
  def customize_time
    I18n.l self.created_at, format: :short
  end
end
