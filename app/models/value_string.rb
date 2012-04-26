class ValueString < Survey
  belongs_to :fields
  alias_attribute :value, :value_str
  attr_accessible  :value_str
end
