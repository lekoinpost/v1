class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.references :garden, null: false
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.boolean :used, default: false 
      t.timestamps
    end
  end
end
