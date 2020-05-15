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
 

  get "/users/:id/edit" do
    erb :"/users/show.html"
  end
end

  