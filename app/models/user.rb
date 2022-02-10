class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: {maximum: Settings.digits.digit_50}

  validates :email, presence: true,
                    length: {maximum: Settings.digits.digit_255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  validates :password, presence: true,
                       length: {minimum: Settings.digits.digit_6}

  before_save :downcase_email

  private
  def downcase_email
    email.downcase!
  end

  has_secure_password
end
