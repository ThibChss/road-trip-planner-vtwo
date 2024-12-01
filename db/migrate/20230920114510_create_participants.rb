class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :trip, null: false, foreign_key: true, type: :uuid
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
