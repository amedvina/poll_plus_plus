class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    comment.author.id == user.id
  end

  def edit?
    comment.author.id == user.id
  end
end