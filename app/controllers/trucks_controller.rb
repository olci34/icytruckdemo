class TrucksController < ApplicationController
    before_action :current_customer, only: [:show] # for layout links
    before_action :set_truck, only: [:show]
    before_action :current_truck, only: [:index, :edit, :update]
    before_action :redirect_if_not_logged_in, only: [:index, :show, :edit, :update]

    def new
        redirect_to trucks_path if logged_in?
        session[:user] = "truck"
        @truck = Truck.new
    end

    def create
        @truck = Truck.new(truck_params)
        if @truck.save
            session[:truck_id] = @truck.id
            redirect_to trucks_path
        else
            render :new
        end
    end

    def index
        if session[:user] == "customer"
            redirect_to customer_trucks_path(current_customer) if !check_owner?
            @customer = Customer.find_by(id: params[:customer_id])
            if params[:search_zipcode]
                @trucks = Truck.in_the_area_of(params[:search_zipcode])
            else
                @trucks = Truck.in_the_area_of(@customer.zipcode)
            end
        else
            @trucks = Truck.in_the_area_of(@truck.zipcode)
        end
    end

    def show
        if @truck && params[:flavors] # If a flavor is searched
            @icecreams = Icecream.search_icecreams_by_flavor(params[:flavors][:flavor_name], @truck)
        elsif @truck
            @icecreams = Icecream.where("truck_id = ?", @truck.id)
        else
            redirect_truck_index
        end
    end

    def edit
    end

    def update
        if @truck.update(truck_params)
            redirect_to trucks_path
        else
            render :edit
        end
    end

    private

    def truck_params
        params.require(:truck).permit(:name, :email, :password, :zipcode)
    end

end