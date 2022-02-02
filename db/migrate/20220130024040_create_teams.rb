class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
    add_index :teams, [:user_id, :created_at]
  end
end
