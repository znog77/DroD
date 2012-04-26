class SurveySpec < ActiveRecord::Base
  attr_accessible :name, :desc
  has_many :surveys
end
