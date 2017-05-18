class User < ApplicationRecord
  validates :first_name, :last_name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :password, length: {minimum: 6}
  validates_confirmation_of :password
  
end
