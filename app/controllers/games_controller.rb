class GamesController < ApplicationController

  # game homepage. I want this to dispay ALL games submitted by all users like a master list.
  get "/games" do
    @games = Game.all
    erb :"/games/collection"
  end

  #brings you to the create a game page.
  get "/games/create" do
    if logged_in?
    erb :"/games/create"
    else
      erb :'/'
    end
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
      @user = current_user
      @game = Game.create(params[:game])
      @user.games << @game
      erb :"/users/profile"
    end

  end

  get '/games/collection' do
    if logged_in?
    erb :"/games/collection"
    else
      erb :"/"
    end
  end

  post '/games/add' do
    #this works but im very suspicious, doesnt display error wont work unless redirect because it takes in the game id? Routes probably
    @user = current_user
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
  get "/games/edit" do
    erb :"/games/edit"
  end

  # Heres the thing. Working on editing your submissions. This edit is going to pose as a delete from the usergames table not from the full collection
  post "/games/edit" do
     
  end

  # this works to end the games relation in join table does not delete from the game itself since its not directly owned by a user
  post "/games/delete" do
    @user = current_user
    @game = Game.find_by_id(params["g"]["id"])
    @user.games.destroy(@game.id)
    
    @success = "Game Removed"
    erb :"/users/profile"
  end
end
