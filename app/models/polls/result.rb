module Polls
  class Result
    def initialize(poll)
      @poll = poll
    end

		def final_result
      max_value = @poll.candidates.map(&:candidate_votes).max
      return [] if max_value.nil?
      
      @poll.candidates.select { |element| element.candidate_votes == max_value }
    end

    def as_json(options = nil)
      {
        winners: final_result.map { |candidate| candidate.title }.join(", ")
      }
    end
  end
end