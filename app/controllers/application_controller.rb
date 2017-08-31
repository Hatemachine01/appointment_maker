class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper


def restricted
end

def about
end


end

