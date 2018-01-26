require 'rack-flash'
class UsersController < ApplicationController
  use Rack::Flash

  get '/users/show' do
    if session[:user_id]
      @events = Event.all
      @user = User.find_by_id(session[:user_id])
      @event = Event.create(:title => params[:title], :date => params[:date], :volunteers_needed => params[:volunteers_needed], :description => params[:description], :user_id => @user.id)
      erb :'users/show'
    else
      redirect to 'users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by(:username => params[:username])
    erb :'users/show'
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else

      redirect '/events'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'

    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id

      redirect '/events'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/events'
    end
  end

  post '/login' do
    # @user = User.create(params[:user])
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/events'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      flash[:message] = "You have signed out. Please Log In"
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
