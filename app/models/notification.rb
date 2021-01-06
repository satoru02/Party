class Notification < ApplicationRecord
  belongs_to :user

  # 読まれたか確認
  def checked
    self.update!(confirmation: true)
  end
end

# 1.entry_request
# 2.entry_approved
# 3.entry_declined
# 4.follow
# 5.post
# 6.web_info