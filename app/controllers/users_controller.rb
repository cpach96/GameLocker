class UsersController < ApplicationController
  #show page

  #profile page is gonna be users collection

  #this redirects you to your homepage from link
  get "/users/profile" do
    if logged_in?
    @user = current_user
    erb :'/users/profile'
    else
      erb :"/welcome"
    end
  end
  ## BUUUUG I cant FIGURE OUT WHY LOGGED_IN WONT WORK HERE WTFFFF??? going to this link breaks it because youre not logged in want to prevent this
  #i think paths are fucced fix this

  #this is going to let you remove a game from your join table 
  get "/users/:id/edit" do

    erb :"/users/new.html"
  end

  post "/users/edit" do
  end

  get "/users/:id/edit" do
    erb :"/users/show.html"
  end
end

  