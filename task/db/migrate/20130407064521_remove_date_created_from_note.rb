class RemoveDateCreatedFromNote < ActiveRecord::Migration
  def up
    remove_column :notes, :date_created
  end

  def down
    add_column :notes, :date_created, :string
  end
end
