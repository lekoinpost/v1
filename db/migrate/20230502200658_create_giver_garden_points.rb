class CreateGiverGardenPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :giver_garden_points do |t|
      t.references :garden, null: false
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.integer :nb_of_points

      t.timestamps
    end
  end
end
