class CreateTeamsRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :teams_relationships do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
    add_index :teams_relationships, :user_id
    add_index :teams_relationships, :team_id
    add_index :teams_relationships, [:user_id, :team_id], unique: true
  end
end
