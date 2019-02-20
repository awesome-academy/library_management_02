class LikesController < ApplicationController
  before_action :load_like, only: %i(destroy)

  def create
    @like = current_user.likes.build book_id: params[:book_id]
    if @like.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to root_path
  end

  def destroy
    if @like.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to root_path
  end

  private
  def likes_params
    params.require(:like).permit :book_id, :user_id
  end

  def load_like
    @like = current_user.likes.find_by book_id: params[:book_id]
    return if @like
    flash[:danger] = t "likes.load_like.error_message"
    redirect_to root_path
  end
end
