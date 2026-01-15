class Garden < ApplicationRecord

  belongs_to :gardener, class_name: "User", foreign_key: "gardener_id"
  has_one_attached :main_image

  before_validation :set_slug


  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :garden_name, :address, :description, :nb_of_points_for_a_gift, presence: true

  validates :description, length: { maximum: 500 }
  serialize :products, Array
  attribute :products, :string, default: [], array: true

  enum status: { active: 'active', inactive: 'inactive' }

  # scope :by_address, lambda { |address|
  #   next if address.blank?
  
  #   coordinates = Geocoder.search(address).first&.coordinates
  #   coordinates ? near(coordinates, 20, order: :distance) : all
  # }

  def set_slug
    self.slug = self.garden_name.parameterize
  end

  # def distance_to(address)
  #   return nil unless address.present? && latitude.present? && longitude.present?
    
  #   distance = Geocoder::Calculations.distance_between([latitude, longitude], Geocoder.coordinates(address))
  #   distance.round(1) # Round the distance to two decimal places
  # end

  def rewards_to_receive
    Reward.where(garden_id: self, used: false)
  end

end