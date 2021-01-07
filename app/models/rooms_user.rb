class RoomsUser < ApplicationRecord
  after_create :create_join_message

  class << self
    def check_duplicate_user(room_id, user_id)
      @user_ids = []
      @exist_rooms_users = self.where(room_id: room_id)
        @exist_rooms_users.each do |v|
          if v.user_id === user_id
            return false
          else
            return user_id
          end
        end
    end
  end

  private

    def create_join_message
      Message.create!(room_id: self.room_id, user_id: self.user_id, classification: 'join')
    end
end