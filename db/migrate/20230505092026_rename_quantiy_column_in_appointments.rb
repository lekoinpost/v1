class RenameQuantiyColumnInAppointments < ActiveRecord::Migration[7.0]
  def change
    rename_column :appointments, :quantiy, :quantity
  end
end
