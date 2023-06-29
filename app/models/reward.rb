class Reward < ApplicationRecord

  belongs_to :giver, class_name: "User", dependent: :destroy
  belongs_to :garden

end
