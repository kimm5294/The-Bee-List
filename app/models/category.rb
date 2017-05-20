class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :goals

  def top_five_goals
    self.goals.sort_by{|goal| goal.users_count}.reverse[0...5]
  end

  def display_current_user_goals(user)
    self.goals.joins(:goals_users).where(goals_users: {user_id: user.id, completed: false})
  end

  def display_completed_user_goals(user)
    self.goals.joins(:goals_users).where(goals_users: {user_id: user.id, completed: true})
  end

  def search_database(search_query)
    database_results = self.goals.select do |goal|
      goal.task.downcase.include?(search_query.downcase) == true
    end
  end

  def database_results_ids(search_query)
    self.search_database(search_query).map{|goal| goal.goal_id}
  end

end
