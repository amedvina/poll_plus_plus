class CommentsController < ApplicationController
  before_action :set_commentable
  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.author_id = Current.user.id

    if @comment.save
      redirect_to @commentable, notice: "Comment created"
    else
      render :new
    end
  end

  def edit
    @comment = @commentable.comments.find(params[:id])
    authorize @comment, policy_class: CommentPolicy
  end

  def update
    @comment = @commentable.comments.find(params[:id])

    authorize @comment, policy_class: CommentPolicy

    if @comment.update(comment_params)
      redirect_to @commentable, notice: "Comment updated"
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to @commentable, notice: "Comment deleted"
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  def pundit_user
    Current.user
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    if params[:poll_id].present?
      @commentable = Poll.find_by_id(params[:poll_id])
    elsif params[:post_id].present?
      @commentable = Post.find_by_id(params[:post_id])
    end
  end
end
