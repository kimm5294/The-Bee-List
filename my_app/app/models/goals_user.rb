class GoalsUser < ApplicationRecord
  validates :user_id, :goal_id, presence: true
end
