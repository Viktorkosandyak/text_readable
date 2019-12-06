class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authenticate_user!
  before_action :authorize_policy

  def index
    @users = User.all.order("created_at ASC")
    render :index
  end

  def show
    render :show
  end

  private

  def authorize_policy
    action_name == 'index' ? authorize(User) : authorize(@user)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
