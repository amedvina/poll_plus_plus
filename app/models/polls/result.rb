module Polls
  class Result
    def initialize(poll)
      @poll = poll
    end

		def winning_candidates
      max_value = @poll.candidates.map(&:candidate_votes).max
      return [] if max_value.nil?
      
      @poll.candidates.select { |element| element.candidate_votes == max_value }
    end
  end
end