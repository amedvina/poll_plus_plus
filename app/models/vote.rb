class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :user, optional: true

  def self.has_voted?(user_id, candidate_id)
    Vote.exists?(user_id: user_id, candidate_id: candidate_id)
  end
end
