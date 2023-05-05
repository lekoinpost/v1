class RenameTypeColumnInAppointments < ActiveRecord::Migration[7.0]
  def change
    rename_column :appointments, :type, :compost_type
  end
end
