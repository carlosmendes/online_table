module SessionsHelper
  
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_order
    o = Order.where(:status => Order.status_active)
    if logged_in?
      o = o.where(:client_id => current_user.id).first
    else
      o = o.where(:session_cookie => session[:cookie_store]).first
    end
    o  
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def manager?
      logged_in? and current_user.manager == true
  end
  
  def check_manager
    unless manager?
      flash[:error] = "Invalid Permissions"
      redirect_to root_path
    end  
  end
  
  def waiter?
      logged_in? and current_user.waiter == true
  end

  def check_waiter
    unless waiter?
      flash[:error] = "Invalid Permissions"
      redirect_to root_path
    end  
  end
  
  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
