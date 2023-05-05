class CreateAppointmentsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments_tables do |t|
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.references :gardener, null: false, foreign_key: { to_table: :users }
      t.date :date
      t.string :quantity
      t.string :compost_type
      t.timestamps
    end
  end
end
