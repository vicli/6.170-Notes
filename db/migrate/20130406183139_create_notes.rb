class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :name
      t.text :description
      t.string :date_created
      t.boolean :starred
      t.integer :owner
      t.string :due_date
      t.string :tag

      t.timestamps
    end
  end
end
