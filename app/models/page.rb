class Page < ActiveRecord::Base
  belongs_to :site
  attr_accessible :totalVisitDuration, :url, :visits
end
