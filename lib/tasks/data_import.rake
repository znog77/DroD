require 'csv'
require 'time'

desc "Get the SQM data from a SQM-L file"
task :import_sqm => :environment do
  id = 2
  i = Instrument.find(id)
  sqm_s= i.survey_specs.find(1)
  time_s= i.survey_specs.find(2)
  puts "Intruments: "+i.name
  CSV.foreach("./data_imports/output.csv") do |row|
    tt = ValueTime.new(:value_time => DateTime.parse(row[0].to_s+"-"+row[1].to_s+"-"+row[2].to_s+" "+row[3].to_s+":"+row[4].to_s+":"+row[5].to_s+" -3:00"))
    tf = ValueFloat.new(:value_flt => row[6].to_f)
    f = Field.new
    f.surveys << tt
    f.surveys << tf
    time_s.surveys << tt
    sqm_s.surveys << tf
    f.save
    time_s.save
    sqm_s.save
    i.fields << f
  end
  i.save
end
