class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to root_path and return
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def create_from_social
    auth = request.env["omniauth.auth"]
    user = User.where(:email => auth['info']['email']).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
  
end
