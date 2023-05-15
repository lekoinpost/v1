class Appointment < ApplicationRecord


  belongs_to :giver, class_name: "User", dependent: :destroy
  belongs_to :gardner, class_name: "User", dependent: :destroy

  after_create :set_giver_gardner_points
  after_update :update_giver_gardner_points

  validates :date, :quantity, :compost_type, presence: true
  
  COMPOST_TYPES = ["biodéchets", "compost mûr"]

  scope :upcoming, -> { where('date >= ?', Date.today) }
  scope :passed, -> { where('date < ?', Date.today) }


  def mark_as_confirmed
    self.update_giver_gardner_points
    self.status = "confirmed"
    self.save
  end

  def set_giver_gardner_points 
    GiverGardnerPoint.create_or_find_by(giver: self.giver, gardner: self.gardner)
  end

  def update_giver_gardner_points
    # Barème de récompenses :
    # 1kg de biodechets = 1 point 
    # 1kg de compost mur = 3 points

    if self.compost_type == "biodéchets"
      self.set_giver_gardner_points += self.quantity * 1
    elsif self.compost_type == "compost mûr"
      self.set_giver_gardner_points += self.quantity * 3
    end
    self.save
  end

end