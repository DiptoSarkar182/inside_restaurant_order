class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    per_page = params[:per_page] || 10

    params[:order_date] ||= Date.today.to_s

    @orders = Order.where("DATE(created_at) = ?", params[:order_date]).order(id: :asc)

    @total_orders = @orders.count
    @total_pending_orders = @orders.where(status: :pending).count
    @total_cooking_orders = @orders.where(status: :cooking).count
    @total_completed_orders = @orders.where(status: :completed).count
    @total_cancelled_orders = @orders.where(status: :cancelled).count

    @orders = @orders.where(status: params[:status]) if params[:status].present?

    if params[:search_orders].present?
      @orders = @orders.joins(order_items: :menu_item).where(
        "menu_items.title ILIKE ?", "%#{params[:search_orders]}%"
      )
    end

    @orders = @orders.page(params[:page]).per(per_page)
  end


  def update
    @order = Order.find(params[:id])
    current_status = params[:status]
    order_date = params[:order_date]

    if @order.update(order_params)
      if current_status.present?
        redirect_to orders_path(status: current_status, order_date: order_date), notice: 'Order status updated successfully.'
      else
        redirect_to orders_path(order_date: order_date), notice: 'Order status updated successfully.'
      end
    else
      if current_status.present?
        redirect_to orders_path(status: current_status, order_date: order_date), alert: 'Failed to update order status.'
      else
        redirect_to orders_path(order_date: order_date), alert: 'Failed to update order status.'
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
