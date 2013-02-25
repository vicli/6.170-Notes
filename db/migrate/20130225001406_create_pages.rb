class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url
      t.references :site
      t.string :url
      t.integer :visits
      t.time :totalVisitDuration

      t.timestamps
    end
    add_index :pages, :site_id
  end
end
