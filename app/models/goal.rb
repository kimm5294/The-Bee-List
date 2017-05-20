class Goal < ApplicationRecord
  validates :task, :category_id, presence: true
  validates :task, uniqueness: true
  validates :api_id, presence: true

  has_many :goals_users
  has_many :users, through: :goals_users
  belongs_to :category

  def users_count
    self.users.count
  end
end
