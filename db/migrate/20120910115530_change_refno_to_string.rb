class ChangeRefnoToString < ActiveRecord::Migration
  def up
    change_table :members do |t|
      t.change :refnum, :string
    end
  end

  def down
    change_table :members do |t|
      t.change :refnum, :integer
    end
  end
end
