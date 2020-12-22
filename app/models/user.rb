class User < ApplicationRecord
  has_many :posts
  has_secure_password
  enum role %i[user manager admin].freeze
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
             presence: true,
             uniqueness: { case_sensitive: false }
end
