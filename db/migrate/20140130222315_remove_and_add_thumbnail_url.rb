class RemoveAndAddThumbnailUrl < ActiveRecord::Migration
  def change
  	remove_column :videos, :tumbnail_url, :string

  	add_column :videos, :thumbnail_url, :string
  end
end
