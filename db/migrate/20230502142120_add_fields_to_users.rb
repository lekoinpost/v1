class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :type, :string
    add_column :users, :garden_name, :string
    add_column :users, :description, :string
    add_column :users, :nb_of_points_for_a_gift, :integer
    add_column :users, :street, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
  end
end
