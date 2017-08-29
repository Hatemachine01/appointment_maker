class AddReconfirmationToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :reconfirmation, :boolean, default: false
  end
end
 
