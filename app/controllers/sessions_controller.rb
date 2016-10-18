#THIS IS A CASH GAME SESSION CONTROLLER, NOT A SESSION FOR A BROWSER!

class SessionsController < ApplicationController

  get '/sessions' do
    erb :'sessions/sessions'
  end

  get '/sessions/new' do
    if !logged_in?
      redirect '/'
    else
      erb :'sessions/new'
    end
  end

  post 'sessions' do

  end



end
