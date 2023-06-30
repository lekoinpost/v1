class Reward < ApplicationRecord

  belongs_to :gardener, class_name: "User", foreign_key: "gardener_id"
  belongs_to :giver, class_name: "User", foreign_key: "giver_id"

  scope :by_giver, ->(user) {where("giver_id = ?", user.id) }

  scope :by_gardener, ->(user) {where("gardener_id = ?", user.id) }

end
