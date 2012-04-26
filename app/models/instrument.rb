class Instrument < ActiveRecord::Base
  attr_accessible :desc, :name, :specs
  #relations
  belongs_to :group
  belongs_to :location
  has_many :fields
  has_many :surveys , :through => :fields
  has_many :survey_specs
end
