class ValueFloat < Survey
  belongs_to :fields
  attr_accessible  :value_flt
  alias_attribute :value, :value_flt
end
