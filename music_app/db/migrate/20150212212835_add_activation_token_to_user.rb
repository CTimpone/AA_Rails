class AddActivationTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :boolean, null: false
  end
end
