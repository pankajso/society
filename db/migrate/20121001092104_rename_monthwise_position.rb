class RenameMonthwisePosition < ActiveRecord::Migration
  def up
    rename_table :monthwise_position, :monthwise_positions
  end

  def down
    rename_table :monthwise_positions, :monthwise_position
  end
end
