class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include BorrowsHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t ".permission"
    redirect_to root_path
  end

  private

  def is_admin?
    return if user_signed_in? && current_user.admin?
    redirect_to root_path
    flash[:danger] = t ".permission"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:full_name, :address , :phone_number, :gender, :role]
  end
end
