class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_users = User.all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end
end
