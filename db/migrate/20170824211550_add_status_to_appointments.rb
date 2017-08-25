class AddStatusToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :status, :boolean , default: false
  end
end
