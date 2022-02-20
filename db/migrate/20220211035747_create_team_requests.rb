class CreateTeamRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :team_requests do |t|
      t.integer :user_id
      t.integer :team_id
      t.boolean :from_team, default: nil
      t.boolean :accepted, default: nil

      t.timestamps
    end
    add_index :team_requests, :team_id
    add_index :team_requests, :user_id
    add_index :team_requests, [:user_id, :team_id], unique: true
  end
end
