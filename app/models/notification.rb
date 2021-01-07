class Notification < ApplicationRecord
  belongs_to :user

  def checked
    self.update!(confirmation: true)
  end
end
