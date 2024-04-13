class AddBalanceToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :balance, :decimal
  end
end
