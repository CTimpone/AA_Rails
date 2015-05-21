class AddActivatedBooleanToUser < ActiveRecord::Migration
  def change
    remove_columns :users, :activation_token
    add_column :users, :activation_token, :string, null: false
    add_column :users, :activated, :boolean
  end
end
