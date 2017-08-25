class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.integer :duration
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end


