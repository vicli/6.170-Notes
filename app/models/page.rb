class Page < ActiveRecord::Base
  belongs_to :site
  attr_accessible :totalVisitDuration, :url, :visits
  
  def avgVisitDuration
    return totalVisitDuration / visits
  end
end
