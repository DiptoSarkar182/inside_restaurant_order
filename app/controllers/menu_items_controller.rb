class MenuItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin, except: [:show]

  def index
    @menu_items = MenuItem.all
  end

  def new
    @menu_item = MenuItem.new
    @categories = Category.all
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to menu_items_path, notice: 'Menu item was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @menu_item = MenuItem.includes(:category).find(params[:id])
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
    @categories = Category.all
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html {redirect_to menu_items_path, notice: "Menu item updated successfully!"}
      else
        format.html {render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to menu_items_path, notice: 'Menu item was successfully destroyed.' }
    end
  end

  def delete_menu_item_image
    @menu_item = MenuItem.find(params[:id])
    image = @menu_item.menu_images.find(params[:image_id])

    respond_to do |format|
      if image.purge
        format.html { redirect_to edit_menu_item_path(@menu_item), notice: 'Image was successfully deleted.' }
      else
        format.html { redirect_to edit_menu_item_path(@menu_item), alert: 'Failed to delete image.' }
      end
    end
  end

  def menu_item_card
    render partial: 'menu_item_card'
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:category_id, :title,
                                      :description, :price, :availability,
                                      menu_images: [])
  end

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
