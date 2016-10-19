#THIS IS A CASH GAME SESSION CONTROLLER, NOT A SESSION FOR A BROWSER!

class SessionsController < ApplicationController
  use Rack::Flash


    get '/sessions' do
      if logged_in?
      erb :'sessions/sessions'
      else
        redirect '/'
      end
    end

##########   CREATE A NEW SESSION   #############

    get '/sessions/new' do
      if !logged_in?
        flash[:message] = "You must be logged in to create a new session."
        redirect '/'
      else
        erb :'sessions/new'
      end
    end

    post '/sessions' do
      if params[:date] == "" || params[:amount_won] == ""
        flash[:message] = "Please fill in all forms."
        redirect '/sessions/new'
      else
        @session = current_user.sessions.create(date: params[:date], amount_won: params[:amount_won], notes: params[:notes])
        flash[:message] = "You have successfully created a new session."
        redirect "/sessions/#{@session.id}"
      end
    end

##########   SHOW SESSION   #############

    get '/sessions/:id' do
      if logged_in?
        @session = Session.find(params[:id])
        erb :'sessions/show'
      else
        flash[:message] = "You must be logged in to view a session."
        redirect '/'
      end

    end

##########   EDIT SESSION   #############

    get '/sessions/:id/edit' do
    if logged_in?
      @session = Session.find_by_id(params[:id])
      if @session.user_id == current_user.id
       erb :'sessions/edit_session'
      else
        flash[:message] = "You must be logged in to edit a new session."
        redirect to '/sessions'
      end
    else
      flash[:message] = "You have to be logged in to edit a session."
      redirect to '/'
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
      flash[:message] = "You have successfully edited this session."

      redirect to "/sessions/#{@session.id}"
    end
  end

##########   DELETE SESSION   #############

  get '/sessions/:id/delete' do
    if logged_in?
      @session = Session.find_by_id(params[:id])
      if @session.user_id == current_user.id
        @session.delete
        flash[:message] = "You have successfully deleted a session."

        redirect to '/sessions'
      else
        redirect to '/sessions'
      end
    else
      flash[:message] = "You have to be logged in to delete a session."
      redirect to '/'
    end
end



end
