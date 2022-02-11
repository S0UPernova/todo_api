class Team < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy
  # has_many :active_relationships, class_name:  "TeamsRelationship",

  #                                 foreign_key: "member_id",
  #                                 dependent:   :destroy
  # has_many :passive_relationships, class_name:  "TeamsRelationship",
  #                                  foreign_key: "team_id",
  #                                  dependent:   :destroy
  # has_many :members_active, through: :active_relationships, source:  :member
  # has_many :members_passive, through: :passive_relationships, source: :team_relationship
  has_many :teams_relationships, dependent: :destroy
  has_many :members, through: :teams_relationships, source: :user
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, length: { maximum: 140 }
  # validates :user_id, presence: true
end