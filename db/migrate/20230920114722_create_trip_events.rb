class CreateTripEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :trip_events do |t|
      t.references :trip, null: false, foreign_key: true
      t.integer :creator_id
      t.string :name
      t.string :event_type
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
