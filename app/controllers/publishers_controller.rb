class PublishersController < ApplicationController
  before_action :load_publisher, only: %i(show edit update)

  authorize_resource

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publishers_params
    if @publisher.save
      flash[:success] = t ".success_message"
      redirect_to publishers_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def index
    @search = Publisher.ransack (params[:q])
    @publishers = @search.result.alphabet.paginate page: params[:page],per_page: Settings.paginate.per_page
  end

  def update
    if @publisher.update_attributes publishers_params
      flash[:success] = t ".update_success"
      redirect_to publishers_path
    else
      render :edit
    end
  end

  private
  def publishers_params
    params.require(:publisher).permit :name, :description
  end

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
    flash[:danger] = t "publishers.load_publisher.error_message"
    redirect_to root_path
  end
end
