class AddVotesToMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :like, :integer, default: 0
  	add_column :monsters, :dislike, :integer, default: 0
    add_column :monsters, :vote_stamps, :text
  end
end
