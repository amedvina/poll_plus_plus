class Candidate < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy
  validates :title, presence: true

  def calculate_result
    votes.count
  end

  def title_with_count
    "#{title} (#{calculate_result})" 
  end
end
