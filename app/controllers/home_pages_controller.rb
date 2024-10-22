class HomePagesController < ApplicationController

  def index
    @home_page_categories = Category.where('avg_rating > ?', 2).limit(5)

    @selected_category_id = if params[:category_id].present?
                              params[:category_id].to_i
                            elsif @home_page_categories.any?
                              @home_page_categories.first.id
                            end

    if @selected_category_id
      @home_page_category_based_menu_items = MenuItem.where(category_id: @selected_category_id).limit(6)
    else
      @home_page_category_based_menu_items = MenuItem.first(6)
    end

    @home_page_menu_items = MenuItem.first(6)

    @menu_items_ratings_with_reviews = MenuItemRating.where(rating: 4..Float::INFINITY).limit(5)

    @home_page_menus_that_our_customer_loved_most = MenuItem.limit(3).order(id: :asc)
    @selected_menu_item = if params[:id]
                            MenuItem.find(params[:id])
                          else
                            @home_page_menus_that_our_customer_loved_most.first
                          end
  end

end
