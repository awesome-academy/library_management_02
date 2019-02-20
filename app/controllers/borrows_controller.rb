class BorrowsController < ApplicationController
  before_action :load_borrow, only: %i(show edit update destroy)
  before_action :check_time_borrow, only: %i(update)
  before_action :load_borrow_details, only: %i(index)

  def create; end

  def show
    @borrow_details = BorrowDetail.load_borrow_details params[:id]
    return unless @borrow_details.blank?
    flash[:danger] = t ".dont_exist"
    redirect_to root_path
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

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
    redirect_to borrows_path
  end

  private
  def borrows_params
    params.require(:borrow).permit :note, :date_borrow, :end_date_borrow
  end

  def load_borrow_details
    @borrow_details = BorrowDetail.load_borrow_details params[:id]
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
end
