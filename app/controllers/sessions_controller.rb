class SessionsController < ApplicationController



def new
end

def create
user = User.find_by_email(user_params[:email])
# If the user exists AND the password entered is correct.
	if user && user.authenticate(user_params[:password])
# Save the user id inside the browser cookie. This is how we keep the user 
# logged in when they navigate around our website.
   session[:user_id] = user.id
   current_user = User.find_by_id(session[:user_id])
   @reuniones = current_user.appointments
   render 'users/profile' 
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end


def destroy
    session[:user_id] = nil
    redirect_to '/'
end


private


def user_params
      params.require(:session).permit(:name, :email, :password)
end

end




