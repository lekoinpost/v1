class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  
  has_one :garden, foreign_key: "gardener_id"
  has_many :appointments
  has_many :conversations, through: :appointments
  has_many :messages
  has_many :giver_garden_points, foreign_key: "giver_id"
  has_many :rewards

  def has_a_garden?
    garden.present?
  end

  def total_points_with(garden)
    GiverGardenPoint.where(giver_id: self.id, garden_id: garden.id).sum(:nb_of_points)
  end

  def full_name 
    "#{self.first_name} #{self.last_name}"
  end

  def nb_of_confirmed_gifts
    Appointment.where(giver_id: self.id, status: "confirmed").count
  end


end
