class AddStatusToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :status, :integer, default: 1
  end
end
