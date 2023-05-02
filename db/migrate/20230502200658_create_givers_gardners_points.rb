class CreateGiversGardnersPoints < ActiveRecord::Migration[7.0]
  def change
    create_table :givers_gardners_points do |t|
      t.references :gardner, null: false, foreign_key: { to_table: :users }
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.integer :nb_of_points

      t.timestamps
    end
  end
end
