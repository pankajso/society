class CreateMonthlyMaintainences < ActiveRecord::Migration
  def change
    create_table :monthly_maintainences do |t|
      t.string :refnum
      t.string :name
      t.date :month
      t.string :comment
      t.float :total_due

      t.timestamps
    end
  end
end
