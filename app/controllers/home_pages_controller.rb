class HomePagesController < ApplicationController

  before_action :redirect_admin_user, only: :index

  def index
    @home_page_categories = Category.where('avg_rating > ?', 2).limit(5)

    @selected_category_id = if params[:category_id].present?
                              params[:category_id].to_i
                            elsif @home_page_categories.any?
                              @home_page_categories.first.id
                            end

    if @selected_category_id
      @home_page_category_based_menu_items = MenuItem.where(category_id: @selected_category_id).limit(5)
    else
      @home_page_category_based_menu_items = MenuItem.first(6)
    end

    @home_page_menu_items = MenuItem.limit(5).order(id: :asc)

    @menu_items_ratings_with_reviews = MenuItemRating.where(rating: 4..Float::INFINITY).limit(5)

    @home_page_menus_that_our_customer_loved_most = MenuItem.limit(3).order(id: :asc)
    @selected_menu_item = if params[:id]
                            MenuItem.find(params[:id])
                          else
                            @home_page_menus_that_our_customer_loved_most.first
                          end
  end

  private

  def redirect_admin_user
    if user_signed_in? && current_user.is_admin?
      redirect_to admin_dashboards_path
    end
  end

end
