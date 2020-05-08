class UsersController < ApplicationController
  #show page

  #profile page is gonna be collection

  # GET: /users
  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"/users/profile"
  end

  
  get "/users/:id/edit" do
    erb :"/users/new.html"
  end


  post "/users/edit" do
    redirect "/users"
  end

  get "/users/:id/edit" do
    erb :"/users/show.html"
  end
end

  