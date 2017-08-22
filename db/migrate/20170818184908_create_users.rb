class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :password_digest
      t.string :email
      t.string :address
      t.string :phone_number
      t.boolean :status , default: false

      t.timestamps
    end
  end
end


