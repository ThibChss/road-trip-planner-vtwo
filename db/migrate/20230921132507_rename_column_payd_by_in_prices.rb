class RenameColumnPaydByInPrices < ActiveRecord::Migration[7.0]
  def change
    rename_column :prices, :payd_by_id, :paid_by_id
  end
end
