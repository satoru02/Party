class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 1postに対して、ユーザーがもつEntryは一つ。

  # 読まれたか確認
  # def checked
  #   self.update!(confirmation: true)
  # end
end
