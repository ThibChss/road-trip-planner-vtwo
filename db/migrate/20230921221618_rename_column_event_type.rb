class RenameColumnEventType < ActiveRecord::Migration[7.0]
  def change
    rename_column :trip_events, :event_type, :category

    change_column_default :trip_events, :category, 'Not Specified'
  end
end
