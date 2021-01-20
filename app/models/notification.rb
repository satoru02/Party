class Notification < ApplicationRecord
  belongs_to :user
  include Scooper

  def checked
    self.update!(confirmation: true)
  end
end
