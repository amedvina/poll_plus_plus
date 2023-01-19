class Candidate < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy
  validates :title, presence: true

  def candidate_votes
    votes.count
  end

  def title_with_count
    "#{title} (#{candidate_votes})" 
  end
end
