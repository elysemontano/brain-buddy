class Topic < ApplicationRecord
  belongs_to :user
  validates :name, :description, :user_id, presence: true
  validates :name, length: { in: 3..50 }
  validates :description, length: { minimum: 10 }
end
