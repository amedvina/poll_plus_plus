class PollsController < ApplicationController
  def index
    @polls = Poll.all
  end

  def show
    @poll = Poll.find(params[:id])
    @new_vote = Vote.new
    @author = @poll.author_id
    @result = Polls::Result.new(@poll)
    @final_result = @result.final_result
  end

  def new
    @poll = Poll.new
    4.times { @poll.candidates.build }
  end

  def create
    @poll = Poll.new(poll_params)
    @poll.author_id = Current.user.id
    
    if @poll.save
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

  private
    def poll_params
      params.require(:poll).permit(:title, :start_time, :end_time, candidates_attributes: [:title, :id, :vote])
    end
end
