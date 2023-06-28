class Appointment < ApplicationRecord

  belongs_to :gardener, class_name: "User", foreign_key: "gardener_id"
  belongs_to :giver, class_name: "User", foreign_key: "giver_id"
  has_one :conversation

  after_create :set_giver_garden_points, :create_conversation
  after_update :update_giver_garden_points

  validates :date, :quantity, :compost_type, presence: true
  
  COMPOST_TYPES = ["biodéchets", "compost mûr"]

  scope :upcoming, -> { where('date >= ?', Date.today) }
  scope :passed, -> { where('date < ?', Date.today) }
  scope :in_same_month_as, ->(start_date) {
    where(date: start_date.beginning_of_month..start_date.end_of_month)
  }
  scope :filter_by_date, ->(date){ where('date = ?', date)}
  scope :by_user, ->(user) {where("giver_id = ? OR gardener_id = ?", user.id, user.id) }

  def mark_as_confirmed
    self.update_giver_garden_points
    self.status = "confirmed"
    self.save
  end

  def set_giver_garden_points 
    GiverGardenPoint.create_or_find_by(giver_id: self.giver.id, garden_id: self.gardener.garden.id)
  end

  def update_giver_garden_points
    # Barème de récompenses :
    # 1kg de biodechets = 1 point 
    # 1kg de compost mur = 3 points

    if self.compost_type == "biodéchets"
      self.set_giver_garden_points += self.quantity * 1
    elsif self.compost_type == "compost mûr"
      self.set_giver_garden_points += self.quantity * 3
    end
    self.save
  end

  def create_conversation
    build_conversation.save
  end

  def start_time
    self.date 
  end

end