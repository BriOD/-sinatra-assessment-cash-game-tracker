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
      @session = current_user.sessions.create(date: params[:date], amount_won: params[:amount_won], notes: params[:notes])
      redirect "/sessions/#{@session.id}"
    end
  end

  get '/sessions/:id' do
    @session = Session.find(params[:id])
    erb :'sessions/show'
  end

  get '/sessions/:id/edit' do
  if logged_in?
    @session = Session.find_by_id(params[:id])
    if @session.user_id == current_user.id
     erb :'sessions/edit_session'
    else
      redirect to '/sessions'
    end
  else
    redirect to '/login'
  end
end

patch '/sessions/:id' do
  if params[:date] == "" || params[:amount_won] == ""
    redirect to "/sessions/#{params[:id]}/edit"
  else
    @session = Session.find_by_id(params[:id])
    @session.date = params[:date]
    @session.amount_won = params[:amount_won]
    @session.notes = params[:notes]

    @session.save
    redirect to "/sessions/#{@session.id}"
  end
end

get '/sessions/:id/delete' do
  if logged_in?
    @session = Session.find_by_id(params[:id])
    if @session.user_id == current_user.id
      @session.delete
      redirect to '/sessions'
    else
      redirect to '/sessions'
    end
  else
    redirect to '/login'
  end
end



end
