class AddProductsToGardners < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :products, :string, array: true, default: [], limit: 30
  end
end
