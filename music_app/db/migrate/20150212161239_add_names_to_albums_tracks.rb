class AddNamesToAlbumsTracks < ActiveRecord::Migration
  def change
    add_column :albums, :name, :string, null: false
    add_column :tracks, :name, :string, null: false
  end
end
