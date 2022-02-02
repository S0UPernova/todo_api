class Team < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, length: { maximum: 140 }
  validates :user_id, presence: true
end