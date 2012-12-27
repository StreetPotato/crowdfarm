class CreateFarmposts < ActiveRecord::Migration
  def change
    create_table :farmposts do |t|
      t.string :title
      t.string :concept
      t.string :tags
      t.integer :target
      t.integer :user_id
      t.integer :votes_count, :default => false

      t.timestamps
    end
  end
end
