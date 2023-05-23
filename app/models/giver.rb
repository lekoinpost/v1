class Giver < User

  has_many :giver_gardener_points, foreign_key: :giver_id, dependent: :destroy

  def total_points_with(gardener)
    GiverGardenerPoint.where(giver: self, gardener: gardener).sum(:nb_of_points)
  end

end