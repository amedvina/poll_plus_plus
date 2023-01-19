class VotesController < ApplicationController
    def create
        @vote = Vote.new(vote_params)

        if @vote.save
          flash[:notice] = "Vote has been submitted"
        else
          flash[:alert] = "Unable to submit vote"
        end
        redirect_to poll_path(@vote.candidate.poll)
    end

      private

    def vote_params
      params.require(:vote).permit(:id, :candidate_id, :poll_id)
    end
end