class Goal < ApplicationRecord
  validates :task, :category_id, presence: true
  validates :task, uniqueness: true

  has_many :goalsusers
  has_many :users, through: :goalsusers
  has_many :categories
end
