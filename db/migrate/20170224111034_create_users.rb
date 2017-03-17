class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.integer :status_cd
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
  end
end
