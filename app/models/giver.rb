class Giver < User
  belongs_to :user
  has_many :giver_garden_points, foreign_key: :giver_id, dependent: :destroy

end