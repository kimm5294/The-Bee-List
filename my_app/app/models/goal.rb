class Goal < ApplicationRecord
  validates :task, :category_id, presence: true
  validates :task, uniqueness: true
end
