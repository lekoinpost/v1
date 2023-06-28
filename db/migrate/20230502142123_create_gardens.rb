class CreateGardens < ActiveRecord::Migration[7.0]
  create_table :gardens do |t|
    t.string :garden_name
    t.string :slug
    t.text :description
    t.integer :nb_of_points_for_a_gift
    t.string :address
    t.string :street
    t.string :zipcode
    t.string :city
    t.string :products, array: true, default: [], limit: 30
    t.float :longitude
    t.float :latitude
    t.timestamps
    t.references :gardener, null: false, foreign_key: { to_table: :users }
  end
end
