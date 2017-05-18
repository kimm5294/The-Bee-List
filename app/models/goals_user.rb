class GoalsUser < ApplicationRecord
  validates :user_id, :goal_id, presence: true

  belongs_to :user
  belongs_to :goal
end
