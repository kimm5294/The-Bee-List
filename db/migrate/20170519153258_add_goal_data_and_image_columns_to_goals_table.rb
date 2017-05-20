class AddGoalDataAndImageColumnsToGoalsTable < ActiveRecord::Migration[5.1]
  def change
    add_column(:goals, :data, :jsonb)
    add_column(:goals, :image_url, :string)
  end
end
