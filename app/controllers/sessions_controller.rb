class SessionsController < ApplicationController

    get '/login' do
      erb :"/users/login"
    end
  
    get '/signup' do
  
      erb :"/users/signup"
    end
  
    post '/login' do
      user = User.find_by(:username => params[:user][:username])  
        if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          @user = User.find(session[:user_id])
          erb :"users/profile"
        else
          @error = "Invalid credentials, Please try your username or password again"
          erb :"/users/login"
        end
    end
  
    post '/signup' do
      ## make sure to add unique users so there cant be duplicates in user array
      if params["user"]["username"].empty? || params["user"]["password"].empty?
        @error = "You did not fill out a required field, please do not leave any blank"
        erb :"users/signup"
      elsif User.find_by_username(params["user"]["username"]) != nil
        @error = "This username already exists please try a different one"
        erb :"users/signup"
      else
        user = User.create(params["user"])
        session["user_id"] = user.id
        @user = User.find(session[:user_id])
        erb :"/users/profile"
    end
  end
  
    get '/logout' do
      session.clear
      redirect '/'
    end

    helpers do
      def logged_in?
        !!session[:user_id]
        
      end
  
      def current_user
        User.find(session[:user_id])
      end
    end
end