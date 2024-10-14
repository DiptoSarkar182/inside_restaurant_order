class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @orders = if params[:status].present?
                Order.where(status: params[:status]).order(id: :asc)
              else
                Order.all.order(id: :asc)
              end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to orders_path, notice: 'Order status updated successfully.'
    else
      redirect_to orders_path, alert: 'Failed to update order status.'
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
