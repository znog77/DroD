class PlotsController < ApplicationController
  def index
  end
  def sqm
    puts params[:sqm][:from].to_s,params[:sqm][:to].to_s
    #binding.pry
    #@data = Instrument.first.surveys.order(:field_id).group_by(&:field_id).values.map{ |x,y| {:x=> x.value.to_i, :y => y.value}}.to_json
    #@data = Instrument.first.surveys.where('field_id IN (SELECT field_id FROM surveys WHERE type=\'ValueTime\' AND DATE(value_time)>"'+params[:sqm][:from].to_s+' AND DATE(value_time)<'+params[:sqm][:to].to_s+'")').order(:field_id).group_by(&:field_id).values.map{ |x,y| {:x=> x.value.to_i, :y => y.value}}.to_json
    timeWindows=['year','month' ,'week','day','hour','minute']
    count=0
    begin
      vals=[]
      timeWindow = timeWindows[count]
      count=count+1
      @conn ||= PG.connect( user: 'gonzalo' , dbname: 'drod_development' )
      sql_sentence = 'SELECT date_trunc(\''+timeWindow+'\', t),avg(v) FROM (SELECT max(value_flt) as v,max(value_time) as t FROM "surveys" INNER JOIN "fields" ON "surveys"."field_id" = "fields"."id" WHERE "fields"."instrument_id" = 2 GROUP BY field_id) AS xy WHERE DATE(t)>\''+params[:sqm][:from].to_s+'\' AND DATE(t)<\''+params[:sqm][:to].to_s+'\' GROUP BY date_trunc(\''+timeWindow+'\',t) ORDER BY date_trunc(\''+timeWindow+'\',t);'
      @conn.exec(sql_sentence) do |result|
        result.each do |row|
            vals << row.values
        end
      end
    puts count.to_s+' '+vals.count.to_s
    end while vals.count < 50 && count<6
      
    @data = vals.map{|x,y| {:x=>Time.parse(DateTime.parse(x).to_s).to_i, :y=>y.to_f }}.to_json
  end
end
