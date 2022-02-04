class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.boolean :completed, default: false
      t.datetime :duedate
      t.datetime :completed_at
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
