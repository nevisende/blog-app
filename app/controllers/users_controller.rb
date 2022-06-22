class UsersController < ApplicationController
  def index
    @all_users = User.all
  end

  def show
    @user = current_user
  end
end
