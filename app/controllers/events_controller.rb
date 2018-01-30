require 'rack-flash'
class EventsController < ApplicationController
  use Rack::Flash

  get '/events' do
    if session[:user_id]
      @events = Event.all
      @user = User.find_by_id(session[:user_id])
      @event = Event.create(:title => params[:title], :date => params[:date], :volunteers_needed => params[:volunteers_needed], :description => params[:description], :user_id => @user.id)
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
        flash[:message] = "Please try again. All field must be filled in."
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
    @event = Event.find_by_id(params[:id])
    if @event.user_id == session[:user_id]
        erb :'events/edit'
  else
      redirect to '/login'
    end
  end

  get '/events/:id/comments' do
    if session[:user_id]
      @event = Event.find(params[:id])
      erb :'/events/comments'
    else
      redirect to 'users/login'
    end
  end

  post '/events/:id/comments' do
        @event = Event.find_by_id(params[:id])
        # @event.comments = params[:comments]
@event.update(params[:event])
         @event.save
        flash[:message] = "You have successfully commented."
        redirect to "/events/#{@event.id}"
      end
# end

patch '/events/:id' do
  @event = Event.find_by_id(params[:id])
    if params[:title] == "" || params[:date] == "" || params[:volunteers_needed] == "" || params[:description] == "" || @event.user_id != session[:user_id]
      flash[:message] = "Edit was unsuccessful. Please try again."
      redirect to "/users/show"
    else
      @event = Event.find_by_id(params[:id])
      @event.title = params[:title]
      @event.date = params[:date]
      @event.volunteers_needed = params[:volunteers_needed]
      @event.description = params[:description]
      @event.comments = params[:comments]
      @event.save
      flash[:message] = "You have successfully updated event."
      redirect to "/events/#{@event.id}"
    end
  end


  delete '/events/:id/delete' do
    if session[:user_id]
      @event = Event.find_by_id(params[:id])
      if @event.user_id == session[:user_id]
        @event.delete
        flash[:message] = "You have successfully deleted event."
        redirect to '/events'
      else
        flash[:message] = "I'm sorry, you don't have permission to delete this event."
        redirect to '/events'
      end
    else
      redirect to '/login'
    end
  end
end
