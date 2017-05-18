class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :password, length: {minimum: 6}
  validates_confirmation_of :password

  has_many :connections_as_friender, class_name: "Connection", foreign_key: "friender_id"
  has_many :connections_as_friendee, class_name: "Connection", foreign_key: "friendee_id"
  has_many :friendees, through: :connections_as_friender
  has_many :frienders, through: :connections_as_friendee
  has_many :goals_users
  has_many :goals, through: :goals_users

  def friends
    self.frienders + self.friendees
  end

  def five_friends
    if self.friends.length >= 5
      self.friends.sample(5)
    else
      self.friends.sample(self.friends.length)
    end
  end


  def is_friends_with?(friendee)
    !!connection(friendee)
  end

  def connection(friendee)
    if !!Connection.find_by(friender_id: self.id, friendee_id: friendee.id)
      return Connection.find_by(friender_id: self.id, friendee_id: friendee.id)
    elsif !!Connection.find_by(friender_id: friendee.id, friendee_id: self.id)
      return Connection.find_by(friender_id: friendee.id, friendee_id: self.id)
    else
      return nil
    end
  end
end
