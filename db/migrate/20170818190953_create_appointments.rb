class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.integer :duration
      t.string :description

      t.timestamps
    end
  end
end
