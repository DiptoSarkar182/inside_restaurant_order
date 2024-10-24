class AdminDashboardsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin


  def index
    @count_of_new_users_on_last_3_day = User.where(created_at: 2.days.ago.beginning_of_day..Time.now).count
    @new_users_on_last_3_day_chart = User.where(created_at: 2.days.ago.beginning_of_day..Time.now)
                            .group_by_day(:created_at)
                            .count
    @x = [
      {
        a: @new_users_on_last_3_day_chart,
        color: "#38bdf8"
      },
      {
        a: { "Tue, 22 Oct 2024"=>3, "Wed, 23 Oct 2024"=>3, "Thu, 24 Oct 2024"=>8 },
        color: "#f87171"
      },
      {
        a: { "Tue, 22 Oct 2024"=>3, "Wed, 23 Oct 2024"=>7, "Thu, 24 Oct 2024"=>8 },
        color: "#4ade80"
      },{
        a: { "Tue, 22 Oct 2024"=>3, "Wed, 23 Oct 2024"=>2, "Thu, 24 Oct 2024"=>8 },
        color: "#fb923c"
      },
    ]
    @total_orders_of_last_7_days_chart = Order.where(created_at: 6.days.ago.beginning_of_day..Time.now.end_of_day)
                                        .group_by_day(:created_at)
                                        .count

    @total_menu_items_per_category_chart = MenuItem.joins(:category).group("categories.title").count

    @most_selling_menu_items_chart = MenuItem.joins(order_items: :order)
                                       .group("menu_items.title")
                                       .count
  end


  private

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
