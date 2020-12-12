class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true
  # before_validation :url_chack

  # callback処理でなく、現在はhttpリクエスト時に使っている。
  def import_time
    self.update! date: customize_time
  end

  # url判定ロジック
  def url_check
    # Netflix
    # Amazon
    # Hulu
  end

  private
    def customize_time; I18n.l self.created_at, format: :short end
end
