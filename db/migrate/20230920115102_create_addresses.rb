class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :trip_event, null: false, foreign_key: true
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
