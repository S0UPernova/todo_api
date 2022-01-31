class Team < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, presence: true, allow_nil: true, length: { maximum: 140 }
  validates :user_id, presence: true
end