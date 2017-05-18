class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :task, null: false, unique: true
      t.references :category, null: false

      t.timestamps
    end
  end
end
