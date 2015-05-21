class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = current_user.made_comments.new(comment_params)
    if @comment.save
      if @comment.commentable_type == "PersonalGoal"
        redirect_to personal_goal_url(@comment.commentable_id)
      else
        redirect_to user_url(@comment.commentable_id)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
