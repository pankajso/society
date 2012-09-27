class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :rulename
      t.float :amount

      t.timestamps
    end
  end
end
