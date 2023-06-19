class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      flash[:notice] = "Vote(s) has been submitted"
    else
      flash[:alert] = "Unable to submit vote"
    end

    @poll = @vote.candidate.poll
    @result = Polls::Result.new(@poll)
    @final_result = @result.final_result

    respond_to do |format|
      format.html { redirect_to poll_path(@vote.candidate.poll) }
      format.turbo_stream
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:candidate_id)
  end
end
