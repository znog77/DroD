class ValueTime < Survey
  belongs_to :fields
  attr_accessible  :value_time
  alias_attribute :value, :value_time
end
