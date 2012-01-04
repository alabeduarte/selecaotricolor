class LoginController < ApplicationController
  
  skip_before_filter :authorize
  
  
  def index
  end
  
  def new
  end
  
  def register
    registered_user = User.create :email => params[:email], :password => params[:password]
    flash[:notice] = 'Congrats! Your account was successfully created.'
    redirect_to users_url
  end
  
  def logon
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to index_url
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def logout
  end

end
