class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
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
    if !logged_in?
      erb :'users/login'
    else
      redirect '/events/home'
    end
  end

  post '/login' do
    # @user = User.create(params[:user])
     @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/events/home'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect to '/login'
  else
  redirect to '/'
   end
end

  end
