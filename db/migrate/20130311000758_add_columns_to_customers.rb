class AddColumnsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :name, :string
    add_column :customers, :hashed_password, :string
    add_column :customers, :salt, :string
  end
end
