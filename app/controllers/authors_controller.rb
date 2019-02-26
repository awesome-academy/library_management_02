class AuthorsController < ApplicationController
  before_action :load_author, except: %i(new create index)

  authorize_resource

  def new
    @author = Author.new
  end

  def create
    @author = Author.new authors_params
    if @author.save
      flash[:success] = t ".success_message"
      redirect_to authors_path
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit; end

  def destroy
    if @author.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to authors_path
  end

  def index
    @search = Author.ransack (params[:q])
    @authors = @search.result.alphabet.paginate page: params[:page],per_page: Settings.author.per_page
  end

  def update
    if @author.update_attributes authors_params
      flash[:success] = t ".update_success"
      redirect_to authors_path
    else
      render :edit
    end
  end

  private
  def authors_params
    params.require(:author).permit :name, :description
  end

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:danger] = t "authors.load_author.error_message"
    redirect_to root_path
  end
end
