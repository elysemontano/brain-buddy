class Card < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validates :question, :answer, :user_id, :topic_id, presence: true
  validates :question, :answer, length: { minimum: 5 }
end
