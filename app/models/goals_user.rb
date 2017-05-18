class GoalsUser < ApplicationRecord
  validates :user_id, :goal_id, presence: true
  validates :goal_id, uniqueness: {scope: :user_id}

  belongs_to :user
  belongs_to :goal
end
