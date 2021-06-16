class StaticController < ApplicationController
    
    def home
        if current_truck
            redirect_to trucks_path
        elsif current_customer
            redirect_to customer_trucks_path(@customer)
        end
    end

end