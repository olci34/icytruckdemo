class OrdersController < ApplicationController
    
    before_action :set_truck, :current_customer
    before_action :redirect_if_not_logged_in, only: [:new, :index]
    
    def new
        redirect_to trucks_path, alert: "Only customer accounts can place order." if !current_customer
        @order = Order.new
        @truck.icecreams.each do |i|
            @order.icecreams_orders.build(icecream_id: i.id)
        end
    end
    
    def index
        if session[:user] == "truck"
            redirect_to truck_orders_path(current_truck) if !check_owner?
            @orders = current_truck.orders
        elsif session[:user] == "customer"
            @orders = @customer.orders
        end
    end

    def create
        @order = Order.new(order_params)
        @order.customer = @customer # Assigned here instead of exposing in hidden_field
        @order.truck = @truck
        @order.update_total
        if @order.save
            redirect_to truck_path(@truck), alert: "Order is placed successfully"
        else
            render :new
        end
    end

    private

    def order_params
        params.require(:order).permit(icecreams_orders_attributes: [:quantity, :icecream_id])
    end

end