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

  post '/sessions' do
    if params[:date] == "" || params[:amount_won] == ""
      redirect '/sessions/new'
    else
      @session = Session.create(params)
      redirect "/sessions/#{@session.id}"
    end
  end

  get '/sessions/:id' do
    @session = Session.find(params[:id])
    erb :'sessions/show'
  end



end
