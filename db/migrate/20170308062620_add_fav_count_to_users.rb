class AddFavCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fav_count, :integer, default: 0
  end
end
