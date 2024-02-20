class Topic < ApplicationRecord
  belongs_to :user
  has_many :cards
  validates :name, :description, :user_id, presence: true
  validates :name, length: { in: 3..50 }
  validates :description, length: { minimum: 10 }
end
