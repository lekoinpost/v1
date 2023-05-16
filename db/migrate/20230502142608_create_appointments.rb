class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :gardner, null: false, foreign_key: { to_table: :users }
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.integer :quantiy
      t.string :compost_type
      t.date :date
      t.timestamps
    end
  end
end
