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
       	p "Here" * 30	
        @reuniones = Appointments.all 
        format.html { render 'profile', notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
    else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
end


def personal
	@current_user = User.find_by_id(params[:user_id])
end


def edit
    @user = User.find(params[:id])
end


def update

	current_user = User.find_by_id(session[:user_id])
	User.update(current_user.id, :address => user_params[:address], :phone_number => user_params[:phone_number])
	render 'personal'
end

private


def user_params
    params.require(:user).permit(:name, :email, :password, :address, :phone_number)
end

end
