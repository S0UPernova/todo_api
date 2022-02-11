class TeamsRelationship < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :team, class_name: "Team"
  validates :user_id, presence: true
  validates :team_id, presence: true
end
