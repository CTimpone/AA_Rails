class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :parent_id
      t.timestamps null: false
    end
    add_index :comments, [:post_id, :user_id, :parent_id]
  end
end
