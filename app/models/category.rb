class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :goals

  def top_five_goals
    self.goals.sort_by{|goal| goal.users_count}.reverse[0...5]
  end
end
