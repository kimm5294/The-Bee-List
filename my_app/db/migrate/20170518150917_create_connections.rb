class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.references  :friender, null: false
      t.references  :friendee, null: false

      t.timestamps
    end
  end
end
