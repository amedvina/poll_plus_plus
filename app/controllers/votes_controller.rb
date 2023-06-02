class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    @poll = @vote.candidate.poll
    @result = Polls::Result.new(@poll)
    @final_result = @result.final_result

    if @vote.save
      flash[:notice] = "Vote(s) has been submitted"
    else
      flash[:alert] = "Unable to submit vote"
    end

    respond_to do |format|
      format.html { redirect_to poll_path(@vote.candidate.poll) }
      format.json { render json: { candidate: @vote.candidate } }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:candidate_id)
  end
end
