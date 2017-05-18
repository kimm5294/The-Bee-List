class CreateGoalsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :goals_users do |t|
      t.references :user, null: false
      t.references :goal, null: false
      t.boolean :completed, default: false
      t.text :review

      t.timestamps
    end
  end
end
