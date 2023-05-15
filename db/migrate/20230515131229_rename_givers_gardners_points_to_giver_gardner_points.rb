class RenameGiversGardnersPointsToGiverGardnerPoints < ActiveRecord::Migration[7.0]
  def change
    rename_table :givers_gardners_points, :giver_gardner_points
  end
end
