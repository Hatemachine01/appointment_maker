class Appointment < ApplicationRecord
has_many :user_appointments, :dependent => :destroy
has_many :users, through: :user_appointments 
end
