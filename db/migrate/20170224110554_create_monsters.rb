class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :level
      t.integer :hp
      t.integer :exp
      t.integer :jexp
      t.integer :atk1
      t.integer :atk2
      t.integer :def
      t.integer :mdef
      t.integer :str
      t.integer :agi
      t.integer :vit
      t.integer :int
      t.integer :dex
      t.integer :luk
      t.integer :scale
      t.integer :race
      t.integer :element

      t.timestamps null: false
    end
  end
end
