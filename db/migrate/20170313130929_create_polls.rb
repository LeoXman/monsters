class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.belongs_to :monster
      t.timestamps null: false
    end
  end
end
