class BooksController < ApplicationController
  include BooksHelper

  before_action :load_category, except: %i(new create index)

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit; end

  def index
    @books = Book.alphabet.search_book(params[:search])
      .paginate page: params[:page],per_page: Settings.book.per_page
    @borrow_detail = current_borrow.borrow_details.build
  end

  private
  def books_params
    params.require(:book).permit :name, :description, :num_of_pages, :image,
      :amount, :author_id, :category_id, :publisher_id
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "books.load_book.error_message"
    redirect_to root_path
  end
end
