class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.string :monster_name
      t.integer :monster_id

      t.timestamps null: false
    end
  end
end
