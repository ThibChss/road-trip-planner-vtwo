class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :trip_event, null: false, foreign_key: true, type: :uuid
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
