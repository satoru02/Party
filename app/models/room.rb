class Room < ApplicationRecord
  has_many :messages
  before_create :create_resource_digest

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

    private

    def create_resource_digest
      self.resource_token = Room.new_token
      self.resource_digest = Room.digest resource_token
    end
end
