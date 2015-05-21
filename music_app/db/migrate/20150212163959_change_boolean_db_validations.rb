class ChangeBooleanDbValidations < ActiveRecord::Migration
  def change
    remove_column :albums, :live
    remove_column :tracks, :bonus

    add_column :albums, :live, :boolean
    add_column :tracks, :bonus, :boolean
  end
end
