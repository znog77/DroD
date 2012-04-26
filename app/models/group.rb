class Group < ActiveRecord::Base
  attr_accessible :contact, :desc, :name

  #relations
  has_many :instruments
end
