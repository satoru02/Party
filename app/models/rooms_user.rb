class RoomsUser < ApplicationRecord
  after_create :create_join_message

  private

    def create_join_message
      Message.create!(room_id: self.room_id, user_id: self.user_id, classification: 'join')
    end
end

# validation
# room_id
# user_id の組み合わせはいちい。