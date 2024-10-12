class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :set_total_categories, :set_total_menu_items
  skip_before_action :authenticate_user!, if: :devise_controller?


  private
  def set_total_categories
    @total_categories = Category.count
  end

  def set_total_menu_items
    @total_menu_items = MenuItem.count
  end

  protected
  def after_sign_in_path_for(resource)
    if resource.is_admin?
      admin_dashboards_path
    else
      super
    end
  end
end
