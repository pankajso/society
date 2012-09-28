class AddMemberIdToRules < ActiveRecord::Migration
  def change
    add_column :rules, :member_id, :integer, :null => false
  end
end
