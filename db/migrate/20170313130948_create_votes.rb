class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
