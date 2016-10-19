class UsersController < ApplicationController



##########   SIGN UP   #############

  get '/signup' do
      if logged_in?
        redirect '/sessions'
      else
      erb :'/users/signup'
    end
  end

##########   CREATE A USER   #############

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Please complete the forms."
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      flash[:message] = "You have successfully signed up."

      redirect '/sessions'
    end
  end


##########   LOG IN   #############

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/sessions'
    end
  end

##########   AUTHENTICATE LOG IN   #############


  post '/login' do
    if params[:username] == "" || params[:password] == ""
      redirect '/login'
    end

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/sessions'
    else
      redirect '/login'
    end
  end


##########   LOG OUT   #############

  get '/logout' do
    session.destroy
    redirect '/'
  end

end
