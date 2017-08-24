class AppointmentsController < ApplicationController


def new
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
  actual_date =  Date.strptime( mixed , '%m/%d/%Y')
  appointment = Appointment.create(start_time: actual_date , duration: duration, description: description)
  current_user = User.find_by_id(session[:user_id])
  
  appointment.users << current_user << appointment_with #aqui se asocia la cita con sus usuario
  current_user.appointments << appointment
  appointment_with.appointments << appointment
  @reuniones = Appointment.all
  render 'users/profile'



end












end
