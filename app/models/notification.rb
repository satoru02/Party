class Notification < ApplicationRecord
  belongs_to :user
  include Pager

  def checked
    self.update!(confirmation: true)
  end
end
