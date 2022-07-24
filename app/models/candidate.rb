class Candidate < ApplicationRecord
  belongs_to :poll

  validates :title, presence: true
  validates :poll_id, presence: true
end
