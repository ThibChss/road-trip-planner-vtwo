class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.integer :payd_by_id
      t.references :trip_event, null: false, foreign_key: true
      t.float :total_paid

      t.timestamps
    end
  end
end
