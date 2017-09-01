class CreateUserAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :user_appointments do |t|
      t.references :user, foreign_key: true, on_delete: :cascade
	  t.references :appointment, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
