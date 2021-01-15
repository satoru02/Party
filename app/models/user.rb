class User < ApplicationRecord
  has_and_belongs_to_many :rooms, :uniq => true
  has_many :messages
  has_many :posts
  has_many :entries
  has_many :entry_responses
  has_many :notifications
  mount_uploader :avatar, AvatarUploader
  has_secure_password
  enum role: %i[user manager admin].freeze
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 235 },
             format: { with:VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil:true
  attr_accessor :online_status

  def check_online
    self.online_status = true
    ActionCable.server.broadcast("AppearanceChannel", { event: 'appear', user_id: self.id, status: self.online_status})
  end

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

  private

    def downcase_email
      self.email = email.downcase
    end
end
