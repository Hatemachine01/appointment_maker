class UsersController < ApplicationController


def index
end

def new
  
  @user = User.new 

end


def create

    @user = User.new(user_params)
    @user.password = user_params[:password]
    # @user.save!
    # render 'profile'
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { render 'profile', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
end


private


def user_params
      params.require(:user).permit(:name, :email, :password)
end

end
