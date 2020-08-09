class PostCommentsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = @book.id
    comment.save
    # redirect
  end


  def destroy
    @post_comment = PostComment.find(params[:book_id])
    @book = @post_comment.book
    if @post_comment.user != current_user
      redirect_to request.referer
    end
    @post_comment.destroy
    @post_comments = @book.post_comments


  end

private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
