class CreatePersonalGoals < ActiveRecord::Migration
  def change
    create_table :personal_goals do |t|
      t.text :body, null: false
      t.integer :user_id, null: false
      t.boolean :public, null: false
      t.boolean :completed, null:false

      t.timestamps
    end

    add_index :personal_goals, :user_id
  end
end
