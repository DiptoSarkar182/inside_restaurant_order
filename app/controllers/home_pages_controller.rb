class HomePagesController < ApplicationController

  def index
    @menu_items = MenuItem.all
  end
end
