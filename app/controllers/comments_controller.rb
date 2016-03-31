class CommentsController < ApplicationController

  def create
    @article = Article.find params[:id]
    if !logged_in?
      flash[:danger] ="You must be logged in to post a comment"
      redirect_to login_path
    else
      @comment = @article.comments.new comment_params
      @comment.user_name = current_user.username
      @comment.article_id = @article.id
      if @comment.save
        flash[:success] ="Comment Addeded"
      else
        flash[:danger] ="something went wrong"
      end
        redirect_to article_path @article
    end
  end

  private
    def comment_params
      params.require(:comments).permit(:comment)
    end
end
