class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :friend_id
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
