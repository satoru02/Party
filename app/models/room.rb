class Room < ApplicationRecord
  has_many :messages
  has_and_belongs_to_many :users
  before_create :create_resource_digest
  after_create :create_rooms_users

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  def authenticated? token
    BCrypt::Password.new(resource_digest).is_password?(token)
  end

    private

    def create_resource_digest
      self.resource_token = Room.new_token
      self.resource_digest = Room.digest resource_token
    end

    def create_rooms_users
      RoomsUser.create!(user_id: self.host_id, room_id: self.id)
    end
end
