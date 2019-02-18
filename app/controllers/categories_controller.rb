class CategoriesController < ApplicationController
  before_action :load_category, except: %i(new create index)

  def new
    @category = Category.new
  end

  def create
    @category = Category.new categories_params
    if @category.save
      flash[:success] = t ".success_message"
      redirect_to categories_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to categories_path
  end

  def index
    @categories = Category.alphabet.search_categories(params[:search])
      .paginate page: params[:page],per_page: Settings.paginate.per_page
  end

  def update
    if @category.update_attributes categories_params
      flash[:success] = t ".update_success"
      redirect_to categories_path
    else
      render :edit
    end
  end

  private
  def categories_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "categories.load_category.error_message"
    redirect_to root_path
  end
end
