class SessionsController < ApplicationController
    
    def truck_login
        redirect_to trucks_path if logged_in?
        session[:user] = "truck"
        @errors = []
    end

    def login
        redirect_to customer_trucks_path(current_customer) if logged_in?
        session[:user] = "customer"
        @errors = []
    end

    def create
        if params[:truck]
            truck_authentication
        elsif params[:customer]
            customer_authentication
        end
    end

    def create_via_fb # Omniauth
        if session[:user] == "truck"
            truck = Truck.find_or_create_by(email: request.env['omniauth.auth']['info']['email']) do |t|
                t.name = "#{request.env['omniauth.auth']['info']['name']}'s Icecream Truck"
                t.password = "password"
            end
            if truck.save
                truck.update(online: true) if truck.online == false
                session[:truck_id] = truck.id
                redirect_to trucks_path
            else
                redirect_to truck_signup_path
            end
        elsif session[:user] == "customer"
            customer = Customer.find_or_create_by(email: request.env['omniauth.auth']['info']['email']) do |t|
                t.name = request.env['omniauth.auth']['info']['name']
                t.password = "password"
            end
            if customer.save
                session[:customer_id] = customer.id
                redirect_to customer_trucks_path(customer)
            else
                redirect_to signup_path
            end
        end
    end

    def destroy
        if session[:truck_id]
            truck = Truck.find_by(id: session[:truck_id])
            truck.online = false
            truck.save
            session.clear
            redirect_to truck_login_path
        elsif session[:customer_id]
            session.clear
            redirect_to login_path
        end
    end

    private

    def truck_authentication
        @truck = Truck.find_by_email(params[:truck][:email])
        if @truck && @truck.authenticate(params[:truck][:password])
            session[:truck_id] = @truck.id
            @truck.update(online: true)
            redirect_to trucks_path
        elsif @truck
            @errors = ["Invalid Password"]
            render :truck_login
        else
            @errors = ["Invalid Email"]
            render :truck_login
        end
    end

    def customer_authentication
        @customer = Customer.find_by_email(params[:customer][:email])
        if @customer && @customer.authenticate(params[:customer][:password])
            session[:customer_id] = @customer.id
            redirect_to customer_trucks_path(@customer)
        elsif @customer
            @errors = ["Invalid Password"]
            render :login
        else
            @errors = ["Invalid Email"]
            render :login
        end
    end
end