class AppointmentsController < ApplicationController


def new
@appointment = Appointment.new
@duration = 1..5
end


def create

  date = params[:date]
  time = params[:time]
  duration = params[:duration].to_i
  description = params[:appointment][:description]
  # actual_date = Date.strptime( date, '%m/%d/%Y')
  mixed =  [date,time].join(" ")
  # start_time =	Time.parse(mixed)
  actual_date =  Date.strptime( mixed , '%m/%d/%Y')

  appointment = Appointment.create(start_time: actual_date , duration: duration, description: description)
  @reuniones = Appointment.all
  render 'users/profile'



end












end
