class Flavor < ApplicationRecord
    has_and_belongs_to_many :icecreams
    validates :name, uniqueness: true, presence: true
end