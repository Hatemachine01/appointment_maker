class AppointmentsController < ApplicationController


def new
  p "ENTRO" * 10
  @appointment = Appointment.new
  @admins = User.where(status: true)
  @duration = 1..5
end


def create

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
  p actual_date =  DateTime.strptime( mixed , format )
  appointment = Appointment.create(start_time: actual_date , duration: duration, description: description )
  current_user = User.find_by_id(session[:user_id])
  users = [current_user, appointment_with]
  appointment.users << users #aqui se asocia la cita con sus usuario
  # current_user.appointments << appointment
  @reuniones = current_user.appointments
  render 'users/profile'

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
  actual_date =  Date.strptime( mixed , '%m/%d/%Y')  #gotta update time format
  duration = params[:duration].to_i
  description = params[:appointment][:description]
  appointment_with = User.find_by_id(params[:with].to_i)
  appointment = Appointment.update(params[:id], :start_time => actual_date , 
  :duration => duration, :description => description )
    #change appointment status if already confirmed
    if appointment.status == true 
      Appointment.update(appointment.id, :status => false , :reconfirmation => true )
    end
  current_user = User.find_by_id(session[:user_id])
  @reuniones = current_user.appointments
  render 'users/profile'
end


def confirm
  appointment = Appointment.update(params[:id], :status => true)
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
  render 'show'
end


def personal_info
  @user = User.find_by_id(params[:id])
end


def destroy
  Appointment.destroy(params[:id])
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
  render 'show'
end

end