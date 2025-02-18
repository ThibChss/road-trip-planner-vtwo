class CreateTripEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :trip_events, id: :uuid do |t|
      t.references :trip, null: false, foreign_key: true, type: :uuid
      t.uuid :creator_id
      t.string :name
      t.string :event_type
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end

    add_index :trip_events, :id, unique: true
  end
end
