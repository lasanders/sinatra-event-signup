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
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end


  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        erb :'tweets/edit'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content] == nil
    redirect to "/tweets/#{@tweet.id}"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
          redirect to "/tweets/#{@tweet.id}/edit"
    end
  end


  delete '/tweets/:id/delete' do
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
end
