class UsersController < ApplicationController

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
      erb :"users/collection"
      #sidenote this works kinda. Change it up to get incorrect password message not redirect to whole new page!
		else
      @error = "Invalid credentials, Please try your username or password again"
      erb :"/users/login"
		end
  end

  post '/signup' do
    if params["user"]["username"].empty? || params["user"]["password"].empty?
      @error = "You did not fill out a required field, please do not leave any blank"
      erb :"users/signup"
    else
      user = User.create(params["user"])
      session["user_id"] = user.id
      erb :"/users/collection"
  end
end

  get '/logout' do
    session.clear
    redirect '/'
  end




  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
