module ApplicationHelper
    def icecream_url(icecream, truck)
        if !icecream.id
            truck_icecreams_path(truck)
        else
            truck_icecream_path(truck, icecream)
        end
    end
end


