class UsersController < ApplicationController
  #show page

  #profile page is gonna be users collection

  #this redirects you to your homepage from link
  get "/users/:id" do
    @user = User.find(session[:user_id])
    erb :"/users/profile"
  end

  #this is going to let you remove a game from your join table 
  get "/users/:id/edit" do

    erb :"/users/new.html"
  end

  post "/users/edit" do
    @user = User.find(session[:user_id])

    redirect "/users/profile"
  end

  get "/users/:id/edit" do
    erb :"/users/show.html"
  end
end

  