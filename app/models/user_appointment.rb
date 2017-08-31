class UserAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :appointment ,  :dependent => :destroy

end
