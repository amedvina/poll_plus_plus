class Poll < ApplicationRecord
  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates

  validates :title, presence: true

  def winning_candidates
    max_value = candidates.map(&:calculate_result).max
    candidates.select { |element| element.calculate_result == max_value }
  end
end
