class Note < ActiveRecord::Base
  attr_accessible :date_created, :description, :due_date, :name, :owner, :starred, :tag
  belongs_to :user

end
