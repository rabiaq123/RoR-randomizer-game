class User < ApplicationRecord
  before_save { 
    self.email = email.downcase # downcase email before saving to database
  } 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username,  presence: true, length: { maximum: 20 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, allow_nil: false
end
