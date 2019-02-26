module BorrowsHelper
  def current_borrow
    borrow = Borrow.find_by id: session[:borrow_id]
    if session[:borrow_id].present? && borrow.present?
      borrow
    elsif user_signed_in?
      @current_user.borrows.new
    else
      Borrow.new
    end
  end
end
