class Survey < ActiveRecord::Base
  attr_accessible :value,:value_str, :value_flt, :value_time
  belongs_to :instrument
end

