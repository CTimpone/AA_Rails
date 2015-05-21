class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :author_id, null: false
      t.string :body, null: false

      t.integer :commentable_id
      t.string :commentable_type
      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :commentable_id
  end
end
