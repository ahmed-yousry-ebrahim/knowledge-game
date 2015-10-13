class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :fbid
      t.integer :lifes , :default => 3
      t.string :category
      t.integer :score , :default => 0
      t.integer :high_score , :default => 0

      t.timestamps
    end
  end
end
