class Page < ActiveRecord::Base
  belongs_to :site
  attr_accessible :totalVisitDuration, :url, :url, :visits
end
