class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to request.path, params: { success: true } }
      else
        format.html { redirect_to request.path, params: { success: false } }
      end
    end
  end

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
