class Gardener < User
  has_one_attached :main_image
  has_many :giver_gardener_points, foreign_key: :gardener_id, dependent: :destroy

  after_create :set_slug
  after_update :set_slug

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  serialize :products, Array
  attribute :products, :string, default: [], array: true

  scope :by_address, lambda { |address|
    if address.present?
      Gardener.near(
        Geocoder.search(address).first.coordinates,
        20,
        order: :distance
      )
    end
  }


  def set_slug
    self.slug = self.garden_name.parameterize
    update_columns(slug: self.garden_name.parameterize)
  end

  def distance_to(address)
    return nil unless address.present? && latitude.present? && longitude.present?
    
    distance = Geocoder::Calculations.distance_between([latitude, longitude], Geocoder.coordinates(address))
    distance.round(1) # Round the distance to two decimal places
  end

end