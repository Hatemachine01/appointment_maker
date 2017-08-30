class UsersController < ApplicationController


before_action :logged_in_user, except: [:new, :create]
before_action :logged_in_user_admin , only: [:index, :searcher, :search]

def index

  @all_users = User.all

end

def new
  @user = User.new 
end


def create

  @user = User.new(user_params)
  @user.password = user_params[:password]
  
    if @user.save
        log_in @user
        @reuniones = @user.appointments
        redirect_to @user

    else
        render 'new'
    end
 
end



def show
@reuniones = current_user.appointments
end


# def profile    
# end


def destroy
  User.destroy(params[:id])
  @all_users = User.all
  render 'index'
end




def personal
	@current_user = current_user
end


def edit
    @user = User.find(current_user.id)
end


def update
	User.update(current_user.id, :address => user_params[:address], :phone_number => user_params[:phone_number])
	render 'personal'
end


def searcher
end


def search
 @results = if params[:name] or params[:email]
  search_key_email = params[:email]
  search_key_name = params[:name]
  User.where("name ILIKE ? OR email ILIKE ?", search_key_name, search_key_email) 
  end
 @results
end


def test
end



def calendar
 @reuniones = current_user.appointments
end



def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end



def logged_in_user_admin
      unless current_user.status?
        flash[:danger] = "ACCESS RESTRICTED"
        redirect_to restricted_path
      end
    end



private


def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation ,  :address, :phone_number)
end

end
