class AddIndexToDebtsAmount100k < ActiveRecord::Migration[7.1]
  def change
    add_index :debts, [:amount, :created_at]
  end
end
