class UsersController < ApplicationController
  def index
    @all_users = User.all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end
end
