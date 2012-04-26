class ValueTime < Survey
  belongs_to :instruments
  attr_accessible  :value_time

  def value
    :value_time
  end
end
