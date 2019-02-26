class UsersController < ApplicationController
  include UsersHelper

  before_action :load_user, except: %i(index new create)
  before_action :authenticate_user!

  authorize_resource

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".sign_up_success"
      redirect_to @user
    else
      render :new
    end
  end

  def index
    @search = User.ransack params[:q]
    @users = @search.result.alphabet.paginate page: params[:page],per_page: Settings.user.per_page
    respond_to do |format|
      format.html
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy_succ"
    else
      flash[:danger] = t ".destroy_failed"
    end
    redirect_to users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :full_name, :email, :address, :phone_number,
    :gender, :password, :password_confirmation
  end

  def is_admin?
    redirect_to(root_path) unless current_user.admin?
  end
end
