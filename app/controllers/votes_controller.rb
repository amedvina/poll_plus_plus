class VotesController < ApplicationController
    def create
        @vote = Vote.new(vote_params)

        if @vote.save
          flash[:notice] = "Vote has been submitted"
          ProcessResultJob.perform_later(@vote.candidate.poll_id)
          redirect_to poll_winners_complete_path()
        else
          flash[:alert] = "Unable to submit vote"
          redirect_to poll_path(@vote.candidate.poll)
        end
    end

      private

    def vote_params
      params.require(:vote).permit(:id, :candidate_id, :poll_id)
    end
end