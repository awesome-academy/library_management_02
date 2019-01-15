class PublishersController < ApplicationController
  before_action :load_publisher, only: %i(show edit update)

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publishers_params
    if @publisher.save
      flash[:success] = t ".success_message"
      redirect_to @publisher
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def index
    @publishers = Publisher.alphabet.search_publisher(params[:search])
      .paginate page: params[:page],per_page: Settings.paginate.per_page
  end

  def update
    if @publisher.update_attributes publishers_params
      flash[:success] = t ".update_success"
      redirect_to @publisher
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
