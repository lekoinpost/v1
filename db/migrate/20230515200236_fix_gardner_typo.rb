class FixGardnerTypo < ActiveRecord::Migration[7.0]
  def change
    
    rename_column :appointments, :gardner_id, :gardener_id
    rename_table :giver_gardner_points, :giver_gardener_points
    rename_column :giver_gardener_points, :gardner_id, :gardener_id
    
  end
end
