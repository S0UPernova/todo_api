class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :project_id }
  validates :description, length: { maximum: 240 }
end
