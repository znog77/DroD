class Field < ActiveRecord::Base
  has_many :surveys
  attr_accessible :id
end
