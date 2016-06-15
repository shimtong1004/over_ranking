class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    session[:user_id] = auth["uid"]
    session[:user_info] = auth["info"]
    session[:debug] = auth.to_yaml
    session[:btag] = auth.info.battletag
    if Rails.env == 'development'
      redirect_to root_path
    else
      redirect_to "https://www.happyhouse.me"
    end
    # redirect_to OmniAuth.config.full_host
    # auth_hash = request.env['omniauth.auth']
#  
    # if session[:user_id]
      # # Means our user is signed in. Add the authorization to the user
      # User.find(session[:user_id]).add_provider(auth_hash)
#    
      # render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
    # else
      # # Log him in or sign him up
      # auth = Authorization.find_or_create(auth_hash)
#    
      # # Create the session
      # session[:user_id] = auth.user.id
#    
      # render :text => "Welcome #{auth.user.name}!"
    # end
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
end
