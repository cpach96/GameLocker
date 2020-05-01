class CreateUsergames < ActiveRecord::Migration
  def change
    create_table :usergames do |t|

      t.timestamps null: false
    end
  end
end
