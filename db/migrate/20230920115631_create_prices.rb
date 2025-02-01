class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices, id: :uuid do |t|
      t.uuid :payd_by_id
      t.references :trip_event, null: false, foreign_key: true, type: :uuid
      t.integer :total_paid

      t.timestamps
    end

    add_index :prices, :id, unique: true
  end
end
