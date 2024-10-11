class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "Category created successfully."}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update(categories_params)
        format.html {redirect_to categories_path, notice: "Category updated successfully."}
      else
        format.html {render :new, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    respond_to do |format|
      format.html {redirect_to categories_path, notice: "Category deleted successfully."}
    end
  end



  private
  def check_admin
    unless current_user.is_admin?
      redirect_to root_path, alert: "Access Denied."
    end
  end

  def categories_params
    params.require(:category).permit(:title, :subtitle, :category_image)
  end
end
