class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.text :requirements
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
    add_index :projects, [:team_id, :created_at]
  end
end
