class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :active_relationships, class_name: "Relationship",
            #myself => active_follower
            foreign_key: "follower_id",
            dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
            #myself => passive_followed
            foreign_key: "followed_id",
            dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_and_belongs_to_many :rooms, :uniq => true
  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :entry_responses, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :avatar

  has_secure_password
  enum role: %i[user manager admin].freeze
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password, presence: true, length: { minimum: 6 }, allow_nil:true
  validates :email, presence: true, length: { maximum: 235 },
             format: { with:VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  attr_accessor :online_status

  def authenticated?(attribute, token)
    token = send("#{attribute}_token")
    return false if token.nil?
    self.activation_token == token
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def generate_activation_token!
    begin
      self.activation_token = SecureRandom.urlsafe_base64
    end
    save!
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def generate_password_token!
    begin
      self.reset_password_token = SecureRandom.urlsafe_base64
    end while User.exists?(reset_password_token: self.reset_password_token)
    self.reset_password_token_expires_at = 1.day.from_now
    save!
  end

  def clear_password_token!
    self.reset_password_token = nil
    self.reset_password_token_expires_at = nil
  end

  def check_online
    self.online_status = true
    ActionCable.server.broadcast("AppearanceChannel", { event: 'appear', user_id: self.id, status: self.online_status})
  end

  def avatar_url(object)
    object.service_url
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

    def downcase_email
      self.email = email.downcase
    end
end
