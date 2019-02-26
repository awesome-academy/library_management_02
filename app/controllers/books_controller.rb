class BooksController < ApplicationController
  include BooksHelper

  before_action :load_book, only: :show

  authorize_resource

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @search = Book.ransack (params[:q])
    @books = @search.result.alphabet.paginate page: params[:page],per_page: Settings.book.per_page
    @borrow_detail = current_borrow.borrow_details.build
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "books.load_book.error_message"
    redirect_to root_path
  end
end
