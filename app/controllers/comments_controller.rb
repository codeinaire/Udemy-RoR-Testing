class CommentsController < ApplicationController
  before_action :set_article

  def create
    # my solution the tests still passed but it may have not passed other tests.
    unless current_user
      flash[:alert] = "Please sign in or sign up first"
      redirect_to new_user_session_path
    else
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save # && user_signed_in?
        flash[:notice] = "Comment has been created"
        #redirect_to article_path(@article)
      else
        flash.now[:alert] = "Comment has not been created" # "Please sign in or sign up first"
        #redirect_to new_user_session_path
      end
      redirect_to article_path(@article)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
