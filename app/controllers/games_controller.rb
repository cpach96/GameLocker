class GamesController < ApplicationController

  # game homepage. I want this to dispay ALL games submitted by all users like a master list.
  get "/games" do
    @games = Game.all
    erb :"/games/collection"
  end

  #brings you to the create a game page.
  get "/games/create" do
    erb :"/games/create"
  end

  # GET: /games/5
  post "/games/create" do
    if params["game"]["title"].empty? || params["game"]["genre"].empty? || params["game"]["price"].empty?  
      @error = "You did not fill out a required field, please do not leave any blank"
      erb :"/games/create"
    elsif Game.find_by_title(params["game"]["title"]) != nil
      @error = "This game has already been added to the list! Please try again"
      erb :"/games/create"
    else
      @user = User.find(session[:user_id])
      @game = Game.create(params[:game])
      @user.games << @game
      erb :"/users/profile"
  end
end

  get '/games/collection' do
    erb :"/games/collection"
  end

  post '/games/add' do
    #this works but im very suspicious, doesnt display error wont work unless redirect because it takes in the game id? Routes probably
    @user = User.find(session[:user_id])
    @game = Game.find_by_id(params["game"]["id"])
    if @user.games.include?(@game)
    @error = "This game already exists in your personal collection! Select another option"
    redirect :'/games'
    else
    @user.games << @game
    erb :'/users/profile'
    end
  end

  #This should only let you edit your own upload to the table
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
