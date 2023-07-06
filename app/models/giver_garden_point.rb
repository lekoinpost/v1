class GiverGardenPoint < ApplicationRecord
  
  belongs_to :giver, class_name: "User"
  belongs_to :garden

end