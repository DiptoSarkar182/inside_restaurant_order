class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @orders = Order.all.order(id: :asc)

    # Filter by status if provided
    @orders = @orders.where(status: params[:status]) if params[:status].present?

    # Search by MenuItem title if provided
    if params[:search_orders].present?
      @orders = @orders.joins(order_items: :menu_item).where(
        "menu_items.title ILIKE ?", "%#{params[:search_orders]}%"
      )
    end
  end


  def update
    @order = Order.find(params[:id])
    current_status = params[:status]

    if @order.update(order_params)
      if current_status.present?
        redirect_to orders_path(status: current_status), notice: 'Order status updated successfully.'
      else
        redirect_to orders_path, notice: 'Order status updated successfully.'
      end
    else
      if current_status.present?
        redirect_to orders_path(status: current_status), alert: 'Failed to update order status.'
      else
        redirect_to orders_path, alert: 'Failed to update order status.'
      end
    end
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end
  def check_admin
    unless current_user.is_admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end
