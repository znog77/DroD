class Instrument < ActiveRecord::Base
  ARBITRARY_WINDOW = 50

  attr_accessible :desc, :name, :specs
  #relations
  belongs_to :group
  belongs_to :location
  has_many :fields
  has_many :surveys , :through => :fields
  has_many :survey_specs

 def timeWindow(from,to)
    value = (to - from).to_i.days
    case
    when value >= ARBITRARY_WINDOW.years
      "%Y0101"
    when value >= ARBITRARY_WINDOW.months
      "%Y%m"
    when value >= ARBITRARY_WINDOW.weeks
      "%Y%W0"
    when value >= ARBITRARY_WINDOW.days
      "%Y%m%d"
    when value >= ARBITRARY_WINDOW.hours
      "%Y%m%d%H"
    when value >= ARBITRARY_WINDOW.minute
      "%Y%m%d%H%M"
    end
  end


end
