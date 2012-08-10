require 'csv'
require 'time'

desc "Get the SQM data from a SQM-L file"
task :import_sqml_leo => :environment do
  id = 2
  i = Instrument.find(id)
  puts "Intruments: "+i.name
  CSV.foreach("./data_imports/sqml_leo.csv") do |row|
    tt = ValueTime.new(:value_time => DateTime.parse(row[0].to_s+"-"+row[1].to_s+"-"+row[2].to_s+" "+row[3].to_s+":"+row[4].to_s+":"+row[5].to_s+" -3:00"))
    tf = ValueFloat.new(:value_flt => row[6].to_f)
    f = Field.new
    f.surveys << tt
    f.surveys << tf
    f.save
    i.fields << f
  end
  i.save
end

desc "Get the SQM data from a SQM-L file"
task :import_sqml_sac => :environment do
  id = 1
  i = Instrument.find(id)
  puts "Intruments: "+i.name
  CSV.foreach("./data_imports/sqml_sac.csv") do |row|
    tt = ValueTime.new(:value_time => DateTime.parse(row[0].to_s+"-"+row[1].to_s+"-"+row[2].to_s+" "+row[3].to_s+":"+row[4].to_s+":"+row[5].to_s+" -0:00"))
    tf = ValueFloat.new(:value_flt => row[6].to_f)
    f = Field.new
    f.surveys << tt
    f.surveys << tf
    f.save
    i.fields << f
  end
  i.save
end

desc "Get the SQM data from a SQM-LR file from El Leoncito"
task :import_sqmlr_leo => :environment do
  id = 3
  i = Instrument.find(id)
  puts "Intruments: "+i.name
  CSV.foreach("./data_imports/sqmlr_leo.csv") do |row|
    if row[0].to_i<1330073100 # There is a problem here with the TS7260 clock
      #binding.pry
      time_correction=6.hours
    else
      time_correction=0.hours
    end
    tt = ValueTime.new(:value_time => Time.at(row[0].to_i)-time_correction)
    tf = ValueFloat.new(:value_flt => row[1].to_f)
    f = Field.new
    f.surveys << tt
    f.surveys << tf
    i.fields << f
  end
  i.save
end

desc "Get the SQM data from a SQM-L file"
task :import_sqmlr_sac => :environment do
  id = 4
  i = Instrument.find(id)
  puts "Intruments: "+i.name
  CSV.foreach("./data_imports/sqmlr_sac.csv") do |row|
    tt = ValueTime.new(:value_time => Time.at(row[0].to_i)-3.hours)
    tf = ValueFloat.new(:value_flt => row[1].to_f)
    f = Field.new
    f.surveys << tt
    f.surveys << tf
    f.save
    i.fields << f
  end
  i.save
end

