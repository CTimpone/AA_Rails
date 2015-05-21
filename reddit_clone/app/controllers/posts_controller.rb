class PostsController < ApplicationController
  before_action :ensure_signed_in, only: [:new, :create]
  before_action :is_owner, only: [:edit, :update]
  before_action :verify_sub_path, only: :show

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save

      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def current_post
    Post.find(params[:id])
  end

  def is_owner
    unless current_user == current_post.user
      flash[:errors] = ["Must be poster to complete that action."]
      redirect_to post_url(current_post)
    end
  end

  def verify_sub_path
    if Post.find_by(id: params[:id]).nil?
      flash[:errors] = ["Invalid post."]
      redirect_to subs_url
    end
  end

end
