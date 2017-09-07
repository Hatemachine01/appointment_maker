class AppointmentsController < ApplicationController

before_action :logged_in_user

def new
  @appointment = Appointment.new
  @admins = User.where(status: true)
  @duration = 1..5
end


def create
  #here we create appointments and the appointment data format is converted
  # from String to DateTime
  date = params[:date]
  time = params[:time]
  duration = params[:duration].to_i
  appointment_with = User.find_by_id(params[:with].to_i)
  description = params[:appointment][:description]
  # actual_date = Date.strptime( date, '%m/%d/%Y')
  mixed =  [date,time].join(" ")
  # start_time =	Time.parse(mixed)
  # original_format =  '%m/%d/%Y  %I:%M %p'
  format = '%m/%d/%Y %I:%M %p'
  actual_date =  DateTime.strptime( mixed , format )
  appointment = Appointment.create(start_time: actual_date , duration: duration, description: description )
  current_user = User.find_by_id(session[:user_id])
  users = [current_user, appointment_with]
  appointment.users << users #aqui se asocia la cita con sus usuario
  # current_user.appointments << appointment
  @reuniones = current_user.appointments
  redirect_to user_path(current_user)

end


def show
 @current_user = User.find_by_id(session[:user_id])
 @reuniones = @current_user.appointments
 @array = []
 @reconfirmation = []
    @reuniones.each do |meeting|
      if meeting.status == false
      @array << meeting
      if meeting.reconfirmation == true
      @reconfirmation << meeting
      end
    end
   end
  @array
  @reconfirmation
 end


def edit
  @admins = User.where(status: true)
  @duration = 1..5
  @appointment = Appointment.find_by_id(params[:id])
end


def update
  date = params[:date]
  time = params[:time]
  mixed =  [date,time].join(" ")
  format = '%m/%d/%Y %I:%M %p'
  actual_date =  DateTime.strptime( mixed , format )
  duration = params[:duration].to_i
  description = params[:appointment][:description]
  appointment_with = User.find_by_id(params[:with].to_i)
  appointment = Appointment.update(params[:id], :start_time => actual_date ,
  :duration => duration, :description => description )
    #change appointment status if already confirmed
    if appointment.status == true
      Appointment.update(appointment.id, :status => false , :reconfirmation => true )
    end
  @reuniones = current_user.appointments
  redirect_to user_path(current_user)
end


def confirm
  appointment = Appointment.update(params[:id], :status => true)
  @reuniones = current_user.appointments
  @array = []
  @reconfirmation = []
    @reuniones.each do |meeting|
      if meeting.status == false
      @array << meeting
      if meeting.reconfirmation == true
      @reconfirmation << meeting
      end
    end
   end
  @array
  @reconfirmation
  render 'show'
end


def personal_info
  @user = User.find_by_id(params[:id])
end


def destroy
  Appointment.destroy(params[:id])
  @reuniones = current_user.appointments
  @array = []
  @reconfirmation = []
    @reuniones.each do |meeting|
        if meeting.status == false
          @array << meeting
          if meeting.reconfirmation == true
            @reconfirmation << meeting
          end
        end
      end
  @array
  @reconfirmation
  render 'show'
end



def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
end


end
