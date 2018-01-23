class EventsController < ApplicationController

  get '/events' do
    if session[:user_id]
      @events = Event.all
       @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      erb :'events/home'
    else
      redirect to 'users/login'
    end
  end

  get '/events/new' do
    if session[:user_id]
      erb :"/events/new"
    else
      redirect to 'users/login'
    end
  end

  post '/events' do
    if params[:title] == "" || params[:date] == "" || params[:volunteers_needed] == "" || params[:description] == ""
      redirect to "/events/new"
    else
      user = User.find_by_id(session[:user_id])
      @event = Event.create(:title => params[:title], :date => params[:date], :volunteers_needed => params[:volunteers_needed], :description => params[:description], :user_id => user.id)
      redirect to "/events/#{@event.id}"
    end
  end

  get '/events/:id' do
    if session[:user_id]
      @event = Event.find_by_id(params[:id])
      erb :'events/show'
    else
      redirect to '/login'
    end
  end


  get '/events/:id/edit' do
    if session[:user_id]
      @event = Event.find_by_id(params[:id])
      if @event.user_id == session[:user_id]
        erb :'events/edit'
      else
        redirect to '/events'
      end
    else
      redirect to '/login'
    end
  end

  patch '/events/:id' do
    if params[:title] == "" || params[:date] == "" || params[:volunteers_needed] == "" || params[:description] == ""
    redirect to "/events/#{@event.id}"
    else
      @event = Event.find_by_id(params[:id])
      @event.title = params[:title]
      @event.date = params[:date]
      @event.volunteers_needed = params[:volunteers_needed]
      @event.description = params[:description]
      @event.save
          redirect to "/events/#{@event.id}/edit"
    end
  end


  delete '/events/:id/delete' do
    if session[:user_id]
      @event = Event.find_by_id(params[:id])
      if @event.user_id == session[:user_id]
        @event.delete
        redirect to '/events'
      else
        redirect to '/events'
      end
    else
      redirect to '/login'
    end
  end
end
