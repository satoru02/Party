class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true
  belongs_to :user
  # before_validation :url_chack

  scope :pager, ->(page: 1, per: 10) {
    num = page.to_i.positive? ? page.to_i - 1 : 0
    limit(per).offset(per.to_i * num)
  }

  # callback処理でなく、現在はhttpリクエスト時に使っている。
  def import_time
    self.update! date: customize_time
  end

  # url判定ロジック
  def url_check
  end

  private
    def customize_time; I18n.l self.created_at, format: :short end
end
