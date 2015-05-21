class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :contacts, :email
    add_index :contacts, :name
  end
end
