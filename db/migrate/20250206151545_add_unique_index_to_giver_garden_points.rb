class AddUniqueIndexToGiverGardenPoints < ActiveRecord::Migration[7.0]
  def change
    add_index :giver_garden_points, [:giver_id, :garden_id], unique: true
  end
end
