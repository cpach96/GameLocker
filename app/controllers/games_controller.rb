class GamesController < ApplicationController

  # game homepage. I want this to dispay ALL games submitted by all users like a master list.
  get "/games/collection" do
    @games = Game.all
    erb :"/games/collection"
  end

  # GET: /games/new
  get "/games/create" do
    erb :"/games/create"
  end

  # GET: /games/5
  post "/games/create" do
  
    if params["game"]["title"].empty? || params["game"]["genre"].empty? || params["game"]["price"].empty?  
      @error = "You did not fill out a required field, please do not leave any blank"
      erb :"/games/create"
    else
      @user = User.find(session[:user_id])
      @game = Game.create(params[:game])
      @user.games << @game
      erb :"/users/profile"
  end
end



  # GET: /games/5/edit
  get "/games/:id/edit" do
    erb :"/games/edit.html"
  end

  # PATCH: /games/5
  patch "/games/:id" do
    redirect "/games/:id"
  end

  # DELETE: /games/5/delete
  delete "/games/:id/delete" do
    redirect "/games"
  end
end
