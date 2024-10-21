class MenuItemForNormalUsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @menu_item_for_normal_user = MenuItem.all
  end
end
