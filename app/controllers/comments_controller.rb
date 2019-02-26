class CommentsController < ApplicationController
  before_action :load_book, only: %i(index create)

  authorize_resource

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    @comments = Comment.paginate page: params[:page],
      per_page: Settings.paginate.per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @comments = Comment.paginate page: params[:page], per_page: Settings.paginate.per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to root_path
  end

  private
  def comment_params
    params.require(:comment).permit :book_id, :user_id, :content
  end

  def load_book
    @book = Comment.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "books.load_book.error_message"
    redirect_to root_path
  end
end
