class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    #The bellow is a multiple-key index that enforces uniqueness,
    #so someone can't follow someone else twice
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
