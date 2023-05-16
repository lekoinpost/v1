class Gardener < User
  has_one_attached :main_image

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

end