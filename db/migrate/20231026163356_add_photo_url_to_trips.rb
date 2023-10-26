class AddPhotoUrlToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :photo_url, :string
  end
end
