class Truck < ApplicationRecord
    has_many :orders, -> { order(created_at: :desc)}
    has_many :customers, through: :orders
    has_many :icecreams
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    has_secure_password

    scope :in_the_area_of, ->(zipcode) {where("zipcode = ?", zipcode)} 


end
