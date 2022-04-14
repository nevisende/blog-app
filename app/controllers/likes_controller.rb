class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(like_params)
    @like.update_likes_counter

    respond_to do |format|
      flash[:notice] = if @like.save
                         'Liked'
                       else
                         'Something went wrong'
                       end
      format.html { redirect_to request.path }
    end
  end

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
