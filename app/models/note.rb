class Note < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :owner, :starred, :tag
  belongs_to :user

  validates :name, :presence => true

  acts_as_rateable



end
