class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :refnum
      t.string :name
      t.string :contactno
      t.string :email

      t.timestamps
    end
  end
end
