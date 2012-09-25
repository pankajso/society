class CreateMonthwiseStatuses < ActiveRecord::Migration
  def change
    create_table :monthwise_statuses do |t|
      t.date :month
      t.string :position

      t.timestamps
    end
  end
end
