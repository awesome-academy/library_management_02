class CartsController < ApplicationController
  def show
    @borrow_details = current_borrow.borrow_details
  end
end
