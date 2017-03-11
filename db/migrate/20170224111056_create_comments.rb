class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :text
      t.references :monster, index: true

      t.timestamps null: false
    end
  end
end
