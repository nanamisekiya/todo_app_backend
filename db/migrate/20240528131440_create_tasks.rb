class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.boolean :completed, default: false
      t.datetime :started_at
      t.integer :time_spent, default: 0

      t.timestamps
    end
  end
end
