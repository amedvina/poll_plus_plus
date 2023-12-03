class ProcessResultJob < ApplicationJob
  queue_as :default
  attr_accessor :result

  def perform(poll_id)
    poll = Poll.find(poll_id)

    max_value = poll.candidates.map(&:candidate_votes).max
    return if max_value.nil?

    poll.poll_winners.destroy_all

    @final_result = poll.candidates.select { |element| element.candidate_votes == max_value }

    @final_result.each do |winner|
      poll.poll_winners.create(candidate: winner)
    end
  end
end