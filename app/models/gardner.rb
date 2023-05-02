class Gardner < User
  has_one_attached :main_image

  after_create :set_slug
  after_update :set_slug

  serialize :products, Array
  attribute :products, :string, default: [], array: true

  def set_slug
    self.slug = self.garden_name.parameterize
    update_columns(slug: self.garden_name.parameterize)
  end

end