require 'bcrypt'

class User < ApplicationRecord
	 include BCrypt

has_secure_password

#validations

validates :name, :email, presence: true
validates :email, uniqueness: true
validates_email_format_of :email, :message => 'is not looking good'



acts_as_messageable

attr :password

def password
    @password ||= Password.new(password_hash)
  end

def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end




def mailboxer_email(object)
 #return the model's email here
end

end
