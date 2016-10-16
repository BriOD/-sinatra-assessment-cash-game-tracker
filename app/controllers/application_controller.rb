require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
    enable :sessions
  end

  get '/' do
    hello world
  end

end
