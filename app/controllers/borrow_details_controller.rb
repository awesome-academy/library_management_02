class BorrowDetailsController < ApplicationController
  before_action :load_borrow, only: %i(create update destroy)
  before_action :load_borrow_detail, only: %i(update destroy)
  before_action :check_quantity, only: :update

  authorize_resource

  def create
    @borrow_detail = @borrow.borrow_details.find_by book_id:
      borrow_detail_params[:book_id]
    if @borrow_detail
      flash[:info] = t ".borrow_existed"
    else
      @borrow_detail = @borrow.borrow_details.build borrow_detail_params
    end
    #check_borrow_details
    @borrow.save
    session[:borrow_id] = @borrow.id
    redirect_to root_path
  end

  def update
    if @borrow_detail.update_attributes borrow_detail_params
      flash[:info] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    if @borrow_detail.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: root_path
  end

  private

  def borrow_detail_params
    params.require(:borrow_detail).permit :number, :book_id
  end

  def load_borrow
    @borrow = current_borrow
    return if @borrow
    flash[:danger] = t ".must_login"
    redirect_to new_user_session_path
  end

  def load_borrow_detail
    @borrow_detail = @borrow.borrow_details.find_by id: params[:id]
    return if @borrow_detail
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def check_borrow_details
    return if @borrow.borrow_details.present?
    flash[:danger] = t ".blank"
    redirect_to root_path
  end

  def check_quantity
    flag = 0
    find_borrow_detail
    @borrow.books.each do |book|
      if @detail.book_id == book.id && (book.amount -
        params[:borrow_detail][:number].to_i).negative?
        flag -= 1
      end
    end
    return if flag.zero?
    flash[:danger] = t(".run_out")
    redirect_to cart_path
  end

  def find_borrow_detail
    @detail = BorrowDetail.find_by book_id: params[:borrow_detail][:book_id]
    return if @detail
    flash[:danger] = t ".no_detail"
    redirect_to root_path
  end
end
