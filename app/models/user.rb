require 'bcrypt'

class User < ApplicationRecord
	 include BCrypt


has_many :user_appointments		,					  :dependent => :destroy
has_many :appointments, through: :user_appointments , :dependent => :destroy



has_secure_password

#validations

validates :name, length: { minimum: 2 } 
validates :name, length: { maximum: 15 } 




validates :name, :email, presence: true
validates :email, uniqueness: true
validates_email_format_of :email, :message => 'is not looking good'



acts_as_messageable

attr :password

def password
    @password ||= Password.new(password_digest)
  end

def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
end


def mailboxer_email(object)
 #return the model's email here
end

end
