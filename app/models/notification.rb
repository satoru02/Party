class Notification < ApplicationRecord
  belongs_to :user

  # 読まれたか確認
  def checked
    self.update!(confirmation: true)
  end
end

# [type]
# entry
# entry_response
# room
