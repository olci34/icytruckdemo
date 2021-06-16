class CustomersController < ApplicationController

    before_action :current_customer, except: [:new, :create] # BLOG POST callbacks
    before_action :redirect_if_not_logged_in, except: [:new, :create]

    def new
        redirect_to customer_trucks_path(current_customer) if logged_in?
        session[:user] = "customer"
        @customer = Customer.new
    end
    
    def create
        @customer = Customer.new(customer_params)
        if @customer.save
            session[:customer_id] = @customer.id
            redirect_to customer_trucks_path(@customer)
        else
            render :new
        end
    end

    def index
        @trucks = Truck.in_the_area_of(@customer.zipcode)
    end

    def show
        redirect_to customer_path(@customer) if !check_owner?
    end

    def edit
        redirect_to edit_customer_path(@customer) if !check_owner?
    end

    def update
        if @customer.update(customer_params)
            redirect_to customer_trucks_path(@customer)
        else
            render :edit
        end
    end

    def wallet
        redirect_to customer_wallet_path(@customer) if !check_owner?
    end

    def update_wallet
        @customer.add_money(params[:customer][:wallet])
        redirect_to customer_wallet_path(@customer)
    end

    def destroy
        @customer.destroy
        session.clear
        redirect_to root_path, alert: "Your account has been deleted"
    end

    private
    
    def customer_params
        params.require(:customer).permit(:name,:email,:password,:zipcode)
    end

end