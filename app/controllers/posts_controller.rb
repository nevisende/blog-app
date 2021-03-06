class PostsController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @user = User.where(id: params[:user_id])[0]
    @post = @user.posts.where(id: params[:id])[0]
    @posts = Post.where(author_id: params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.update_posts_counter

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post created succesfully'
        format.html { redirect_to "#{users_path}/#{current_user.id}" }
      else
        flash[:notice] = 'Failed creation a post. Try again'
        format.html { render :new }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.posts_counter -= 1
    @post.destroy!
    redirect_to user_posts_path(id: @author.id), notice: 'Post was deleted successfully!'
  end

  def posts
    user = User.find(params[:user_id])

    respond_to do |format|
      format.json { render json: user.posts }
    end
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text, :comments_counter, :likes_counter)
  end
end
