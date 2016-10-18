#THIS IS A CASH GAME SESSION CONTROLLER, NOT A SESSION FOR A BROWSER!

class SessionsController < ApplicationController

  get '/sessions' do
    erb :'sessions/sessions'
  end
end
