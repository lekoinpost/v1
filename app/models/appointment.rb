class Appointment < ApplicationRecord

  belongs_to :gardener, class_name: "User", foreign_key: "gardener_id"
  belongs_to :giver, class_name: "User", foreign_key: "giver_id"
  has_one :conversation

  after_create :set_giver_garden_points, :create_conversation

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
  
    giver_gardener_points = GiverGardenPoint.select(:id, :nb_of_points).find_or_create_by(giver_id: self.giver.id, garden_id: self.gardener.garden.id)


    points = case self.compost_type
            when "biodéchets"
              self.quantity
            when "compost mûr"
              self.quantity * 3
            else
              0
            end
  
    giver_gardener_points.increment!(:nb_of_points, points)

    create_reached_rewards

  end
  
  def create_reached_rewards

    giver_gardener_points = GiverGardenPoint.find_by(giver_id: self.giver.id, garden_id: self.gardener.garden.id)

    # Si une récompense est atteinte
    while giver_gardener_points.nb_of_points >= self.gardener.garden.nb_of_points_for_a_gift
      # Créer une récompense
      Reward.create(giver_id: self.giver.id, garden_id: self.gardener.garden.id)
      # Retirer le points utilisés
      lost_points = self.gardener.garden.nb_of_points_for_a_gift
      new_quantity = giver_gardener_points.nb_of_points  - lost_points
      giver_gardener_points.update(nb_of_points: new_quantity)
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
    Reward.where(giver_id: self.giver.id, garden_id: self.gardener.garden.id, used: false).count
  end

end