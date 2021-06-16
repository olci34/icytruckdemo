class IcecreamsOrder < ActiveRecord::Base
    belongs_to :icecream
    belongs_to :order
    
    def calculate_total
        self.total = self.icecream.price * self.quantity
    end
end