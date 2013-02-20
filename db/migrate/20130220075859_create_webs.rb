class CreateWebs < ActiveRecord::Migration
  def change
    create_table :webs do |t|
      t.string :name
      t.integer :visits

      t.timestamps
    end
  end
end
