class PersonalGoalsController < ApplicationController

  before_action :ensure_owner, only: :show

  def index
    @personal_goals = PersonalGoal.where(public: true)
    render :index
  end

  def new
    @personal_goal = PersonalGoal.new
    render :new
  end

  def create
    @personal_goal = current_user.personal_goals.new(goal_params)

    if @personal_goal.save
      redirect_to personal_goal_url(@personal_goal)
    else
      flash[:errors] = @personal_goal.errors.full_messages
      render :new
    end
  end

  def show
    @personal_goal = PersonalGoal.find(params[:id])
    render :show
  end

  def edit
    @personal_goal = PersonalGoal.find(params[:id])
    render :edit
  end

  def update
    @personal_goal = PersonalGoal.find(params[:id])

    if @personal_goal.update(goal_params)
      redirect_to personal_goal_url(@personal_goal)
    else
      flash[:errors] = @personal_goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @personal_goal = PersonalGoal.find(params[:id])
    @personal_goal.destroy
    redirect_to personal_goals_url
  end

  private
  def goal_params
    params.require(:personal_goal).permit(:body, :public, :completed)
  end

  def ensure_owner
    unless PersonalGoal.find(params[:id]).public || current_user == PersonalGoal.find(params[:id]).user
      redirect_to personal_goals_url
    end
  end
end
