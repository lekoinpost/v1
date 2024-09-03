class AddOpeningHoursToGardens < ActiveRecord::Migration[7.0]
  def change
    add_column :gardens, :opening_hours, :text
  end
end
