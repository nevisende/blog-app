class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.where(id: params[:user_id])[0]
    @post = @user.posts.where(id: params[:id])[0]
    @posts = Post.where(author_id: params[:user_id])
  end
end
