class CreatePaidForTripEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :paid_for_trip_events, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :price, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
