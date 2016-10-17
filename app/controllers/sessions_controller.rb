class SessionsController < ApplicationController

  get '/sessions' do
    erb :'sessions/sessions'
  end
end
