class Project < ApplicationRecord
  belongs_to :team
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :team_id }
  validates :description, length: { maximum: 140 }
  validates :requirements, length: { maximum: 500 }
end
