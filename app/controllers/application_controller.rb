require './config/environment'


class ApplicationController < Sinatra::Base

    configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
    enable :sessions
    use Rack::Flash

  end

  get '/' do
    erb :'index'
  end

  helpers do
  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:id) if session[:id]
  end
end

end
