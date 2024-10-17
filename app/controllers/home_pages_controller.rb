class HomePagesController < ApplicationController

  def index
    @menu_items = MenuItem.first(6)
  end
end
