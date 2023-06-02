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

  def as_json(options = nil)
    {
      id: id,
      title: title,
      poll_id: poll_id,
      created_at: created_at,
      updated_at: updated_at,
      candidate_votes: candidate_votes,
      title_with_count: title_with_count,
    }
  end
end
