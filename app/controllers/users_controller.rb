class UsersController < ApplicationController
  skip_before_action :authenticate_request
  
  def index
    @all_users = User.all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
  end
end
