class User < ActiveRecord::Base

  has_many :articles, dependent: :destroy  # dependent: destroy = deletes all articles that are linked to the user if its ever deleted.
  before_save { self.email = email.downcase }

  validates :username,presence: true,
                      uniqueness: { case_sensitive: false}, # checks uniquenes but ignores case-sesitivity
                      length: { minimum:3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum:105 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end
