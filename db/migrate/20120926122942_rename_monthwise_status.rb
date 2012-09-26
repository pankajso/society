class RenameMonthwiseStatus < ActiveRecord::Migration
  def up
    rename_table :monthwise_statuses, :monthwise_position
  end

  def down
    rename_table :monthwise_position, :monthwise_statuses
  end
end
