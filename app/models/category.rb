class Category < ApplicationRecord
  has_many :posts

  scope :pager, ->(page: 1, per: 10) {
    num = page.to_i.positive? ? page.to_i - 1 : 0
    limit(per).offset(per.to_i * num)
  }
end
