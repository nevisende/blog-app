class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.update_comments_counter

    respond_to do |format|
      flash[:notice] = if @comment.save
                         'Comment created Successfully'
                       else
                         'something went wrong'
                       end
      format.html { redirect_to request.path }
    end
  end

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
