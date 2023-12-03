class PollsController < ApplicationController
  def index
    @polls = Poll.all
  end

  def show
    @poll = Poll.find(params[:id])
    @new_vote = Vote.new
    @author = @poll.author_id

    @final_result = @poll.poll_winners

    # respond_to do |format|
    #   format.html
    #
    #   format.turbo_stream do
    #     render turbo_stream: turbo_stream.update(
    #       "poll-results-frame",
    #       partial: "winners_list",
    #       locals: { poll: @poll, winners: @poll.poll_winners }
    #     )
    #     format.turbo_stream { render partial: "results" }
    #   end
    # end
  end

  def new
    @poll = Poll.new
    4.times { @poll.candidates.build }
  end

  def create
    @poll = Poll.new(poll_params)
    @poll.author_id = Current.user.id

    if @poll.save
      ProcessPollJob.perform_later(@poll.id)

      redirect_to @poll
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def update
    @poll = Poll.find(params[:id])
    
    if @poll.update(poll_params)
      redirect_to @poll
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    redirect_to root_path, status: :see_other
  end

  def completion_status
    @poll_id = params[:id].to_i
    @poll = Poll.find(@poll_id)
    @completed = @poll.processed
    render json: { completed: @completed }
  end

  private
    def poll_params
      params.require(:poll).permit(:title, :start_time, :end_time, candidates_attributes: [:title, :id, :vote])
    end
end
