class Admin::BorrowsController < ApplicationController
  before_action :load_borrow, except: %i(update index)
  before_action :check_time_borrow, only: %i(update)
  before_action :load_borrow_details, only: %i(index)
  before_action :is_admin?, only: %i(accept_request deny_request)
  before_action :check_quantity, only: %i(accept_request)

  def show
    @borrow_details = BorrowDetail.load_borrow_details params[:id]
    return unless @borrow_details.blank?
    flash[:danger] = t ".dont_exist"
    redirect_to root_path
  end

  def edit; end

  def index
    @borrows = Borrow.newest.paginate page: params[:page],
      per_page: Settings.paginate.per_page
    return if @borrows
    flash[:danger] = t (".no_borrow")
    redirect_back fallback_location: root_path
  end

  def update
    if @borrow.update_attributes borrows_params
      flash[:success] = t ".update_success"
      redirect_to @borrow
    else
      render :edit
    end
  end

  def destroy
    if @borrow.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to fallback_location: root_path
  end

  def accept_request
    if @borrow.accept!
      update_quantity
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: root_path
  end

  def deny_request
    if @borrow.update_attributes deny_borrow_params
      @success = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to admin_borrows_path
  end

  private
  def borrows_params
    params.require(:borrow).permit :note, :date_borrow, :end_date_borrow
  end

  def load_borrow_details
    @borrow_details = BorrowDetail.load_borrow_details params[:id]
  end

  def deny_borrow_params
    params.require(:borrow).permit :note, :status
  end

  def load_borrow
    @borrow = Borrow.find_by id: params[:id]
    return if @borrow
    flash[:danger] = t "borrows.load_borrow.error_message"
    redirect_to root_path
  end

  def check_time_borrow
    return if params[:borrow][:date_borrow] < params[:borrow][:end_date_borrow]
    flash[:danger] = t ".error"
    redirect_to edit_borrow_path
  end

  def check_quantity
    flag = 0
    @borrow.borrow_details.each do |borrow_detail|
      @borrow.books.each do |book|
        if borrow_detail.book_id == book.id && (book.amount -
          borrow_detail.number).negative?
          flag -= 1
        end
      end
    end
    return if flag.zero?
    flash[:danger] = t(".run_out")
    redirect_to borrows_path
  end

  def update_quantity
    @borrow.borrow_details.each do |request_detail|
      @borrow.books.each do |book|
        if request_detail.book_id == book.id
          book.amount -= request_detail.number
          book.update_attribute(:amount, book.amount)
        end
      end
    end
  end
end
