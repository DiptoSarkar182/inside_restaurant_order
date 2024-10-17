class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :menu_item


  after_create :update_menu_item_revenue
  after_update :update_menu_item_revenue

  private

  def update_menu_item_revenue
    revenue = quantity * price
    menu_item.increment!(:revenue, revenue)
  end
end
