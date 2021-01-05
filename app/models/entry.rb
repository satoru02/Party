class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 1postに対して、ユーザーがもつEntryは一つ。
end
