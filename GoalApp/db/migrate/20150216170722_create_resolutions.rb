class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.text :body, null: false
      t.integer :user_id, null: false
      t.boolean :public, null: false
      t.boolean :completed, null:false

      t.timestamps
    end

    add_index :resolutions, :user_id
  end
end
