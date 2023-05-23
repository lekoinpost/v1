class GiverGardenerPoint < ApplicationRecord
  
  belongs_to :giver, class_name: "User", dependent: :destroy
  belongs_to :gardener, class_name: "User", dependent: :destroy

end