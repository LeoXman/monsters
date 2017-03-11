class AddOwnToMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :own, :integer
  end
end
