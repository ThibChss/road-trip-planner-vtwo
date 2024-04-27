class AddSlugToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :slug, :string
    add_index :trips, :slug, unique: true
  end
end
