class SessionsController < ApplicationController

  def new 
    
  end 

  def create
  
    if params[:email] && params[:password]
      user = User.find_by_email(params[:email].downcase.strip)

      # If the user exists and the password entered is correct.
      if user = User.authenticate_with_credentials(params[:email], params[:password])
        # Save the user id inside the browser cookie.
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        redirect_to '/'
      else
      # If user's login doesn't work, send them back to the login form.
        redirect_to '/login'
      end
    else
      redirect_to '/login'
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
