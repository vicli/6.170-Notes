class ChangeTimeFormat < ActiveRecord::Migration
  def change
    change_column(:pages, :totalVisitDuration, :float)
  end
end
