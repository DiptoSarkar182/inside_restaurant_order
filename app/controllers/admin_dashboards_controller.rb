class AdminDashboardsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin


  def index
    @menu_items = MenuItem.all
  end

  private

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
