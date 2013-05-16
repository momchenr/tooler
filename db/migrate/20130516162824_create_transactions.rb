class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :status
      t.integer :item_id
      t.integer :employee_id

      t.timestamps
    end
    add_index :transactions, :item_id
    add_index :transactions, :employee_id
  end

end
