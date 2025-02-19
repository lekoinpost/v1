class Appointment < ApplicationRecord

  belongs_to :gardener, class_name: "User", foreign_key: "gardener_id"
  belongs_to :giver, class_name: "User", foreign_key: "giver_id"
  has_one :conversation

  after_create :set_giver_garden_points, :create_conversation

  validates :quantity, presence: true

  # validates :date, presence: { message: "Merci de saisir une date." }
  # validates :compost_type, presence: { message: "Merci de saisir un type de compost." }

  validates :date, presence: true
  validates :compost_type, presence: true

  
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
    GiverGardenPoint.transaction do
      GiverGardenPoint.find_or_create_by!(giver_id: self.giver.id, garden_id: self.gardener.garden.id)
    end
    rescue ActiveRecord::RecordNotUnique
    retry  #
  end

  def update_giver_garden_points
    giver_gardener_points = GiverGardenPoint.find_or_create_by(
      giver_id: self.giver.id,
      garden_id: self.gardener.garden.id
    )
  
    giver_gardener_points.with_lock do
      points = case self.compost_type
              when "biodéchets"
                self.quantity
              when "compost mûr"
                self.quantity * 3
              else
                0
              end
  
      giver_gardener_points.increment!(:nb_of_points, points)
  
      create_reached_rewards(giver_gardener_points)
    end
  end
  
  def create_reached_rewards(giver_gardener_points)
    gift_threshold = self.gardener.garden.nb_of_points_for_a_gift.to_i
    return if gift_threshold <= 0  # Prevent infinite loop
  
    while giver_gardener_points.nb_of_points >= gift_threshold
      Reward.create!(giver_id: self.giver.id, gardener_id: self.gardener.id)
  
      giver_gardener_points.update!(nb_of_points: giver_gardener_points.nb_of_points - gift_threshold)
    end
  end
  

  def create_conversation
    build_conversation.save
  end

  def start_time
    self.date 
  end

  def passed?
    self.date < Date.today
  end

  def confirmed?
    self.status == "confirmed"
  end

  def nb_of_unused_rewards 
    Reward.where(giver_id: self.giver.id, gardener_id: self.gardener.garden.id, used: false).count
  end

end