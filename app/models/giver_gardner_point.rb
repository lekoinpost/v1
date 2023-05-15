class GiverGardnerPoint < ApplicationRecord
  
  belongs_to :giver, class_name: "User", dependent: :destroy
  belongs_to :gardner, class_name: "User", dependent: :destroy
end