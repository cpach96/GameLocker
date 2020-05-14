class GamesController < ApplicationController

  # game homepage. I want this to dispay ALL games submitted by all users like a master list. Games will not be removed from this list. Duplicates cannot exist

  get "/games" do
    if logged_in?
    @games = Game.all
    erb :"/games/collection"
    else
      redirect :'/'
    end
  end

  #brings you to the create a game page. Only if logged in
  get "/games/create" do
    if logged_in?
    erb :"/games/create"
    else
      redirect :"/"
    end
  end

  #Games creation page. Can account for all empty params and counters existing games in array. Adds to users join table and game table.
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

  #only lets you view collection if you're logged in. Redirects home if not
  get '/games/collection' do
    if logged_in?
    erb :"/games/collection"
    else
      redirect :"/"
    end
  end

  #uses dynamic checkboxes based of id of game and joins it into the users table regardless of creator. Accounts for duplicates in the users table
  # correlates to the inject on array in the profile view. Takes total sum of g.prices for all iterations and uses base of 0 to work around a nil value which would break it. Thinking on how to acct for no select
  post '/games/add' do
    #Where did @error go lol its gone must fix. also fix this tomorrow for being empty throws error
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


  # this works to end the games relation in join table does not delete from the game itself since its not directly owned by a user. Can account for no selection
  post "/games/delete" do
    @user = current_user
    if params.empty?
      @error = "No game selected please try again"
      erb :"/users/profile"
    else
    @game = Game.find_by_id(params["g"]["id"])
    @user.games.destroy(@game.id)
    @success = "Game Removed"
    erb :"/users/profile"
    end
  end



end
