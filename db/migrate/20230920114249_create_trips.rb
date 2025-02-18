class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips, id: :uuid do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :trips, :id, unique: true
  end
end
