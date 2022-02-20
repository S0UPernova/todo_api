class Team < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy
  has_many :teams_relationships, dependent: :destroy
  has_many :members, through: :teams_relationships, source: :user
  has_many :team_requests, dependent: :destroy
  has_many :requests, through: :team_requests, source: :user
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, length: { maximum: 140 }
  validates :user_id, presence: true
end