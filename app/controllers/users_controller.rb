class UsersController < ApplicationController
  #show page

  #profile page is gonna be users collection

  #this redirects you to your homepage from link
  get "/users/profile" do
    if logged_in?
    @user = current_user
    erb :'/users/profile'
    else
      redirect :'/'
    end
  end
  ## BUUUUG I cant FIGURE OUT WHY LOGGED_IN WONT WORK HERE WTFFFF??? going to this link breaks it because youre not logged in want to prevent this
  #i think paths are fucced fix this. Fixed 5/13


  get "/users/:id/edit" do
    erb :"/users/show.html"
  end
end

  