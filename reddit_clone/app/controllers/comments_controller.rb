class CommentsController < ApplicationController
  before_action :verify_comment_path, only: :show

  def new
    @comment = Comment.new
    render :new
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to post_url(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end

  def verify_comment_path
    if Comment.find_by(id: params[:id]).nil?
      flash[:errors] = ["Invalid comment."]
      redirect_to subs_url
    end
  end
end
