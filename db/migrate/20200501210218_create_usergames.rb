class CreateUsergames < ActiveRecord::Migration
  def change
    create_table :usergames do |t|
      t.integer :user_id
      t.integer :game_id

    end
  end
end

#reworked from old project. Since the game can have multiple owners removed genre table and merged with game as a string. Created new table usergames which will join users and games so a user can have multiple games
#and a game and belong to multiple users.