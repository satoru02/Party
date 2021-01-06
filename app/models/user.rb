class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  # include JWTSessions::Token

  has_and_belongs_to_many :rooms
  has_many :messages
  has_many :posts
  has_many :entries
  has_many :invitations
  has_many :notifications

  has_secure_password
  enum role: %i[user manager admin].freeze
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 235 },
             format: { with:VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil:true

  def attributes
    {
      id: id,
      email: email,
      role: role,
      about: about,
      web_url: web_url,
      name: name,
      location: location,
      username: username,
      youtube_url: youtube_url,
      facebook_url: facebook_url,
      instagram_url: instagram_url,
      filmarks_url: filmarks_url,
    }
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

  # class << self
  #   def authorized_by_cookie(jwt)
  #     # cookie_based_auth(jwt)
  #     authorize_request(jwt)
  #   end
  # end

  private

    def downcase_email
      self.email = email.downcase
    end

    # def cookie_based_auth(jwt)
    #   @raw_token = token_from_cookies(jwt)
    # end

    # def token_from_cookies(jwt)
    #   token = request_cookies[JWTSessions.cookie_by(jwt)]
    #   token
    # end

    # def authorize_request(jwt)
    #   @payload = Token.decode(jwt)
    # end
end
