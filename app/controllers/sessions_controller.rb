class SessionsController < ApplicationController
  include SessionsHelper

  def create
    user = User.find_by(email: params[:session][:email].downcase) # finding user by email in Users table

    if user && user.password == params[:session][:password] # if user exists and password is correct
      log_in user
      flash[:notice] = "Logged in successfully."
      redirect_to user # redirect to user's profile page
    else
      if user == nil
        flash.now[:alert] = "There is no user with that email address. Sign up now!"
      else
        flash.now[:alert] = "Invalid password."
      end

      render 'new'
    end
  end

  def destroy
    log_out
    flash.now[:notice] = "You have been logged out."
    redirect_to login_path
  end

end