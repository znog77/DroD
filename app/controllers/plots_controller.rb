class PlotsController < ApplicationController
  def index
  end
  def sqm
    from, to = params[:sqm][:from].to_s, params[:sqm][:to].to_s
    # habria que ordenar esto de una manera mas logica, como una busqueda binaria(del medio hacia los costados o tener un contador en el modelo para saber cual es el mas problable, y ordenar esto mediante la base asi se ordenaria por la probabilidad mas cercana)
    ['year','month','week','day','hour','minute'].each do |value|
      sample = Instrument.find_by_sql("SELECT date_trunc('" + value + "', t) as date,avg(v) as value FROM (SELECT max(value_flt) as v,max(value_time) as t FROM surveys INNER JOIN fields ON surveys.field_id = fields.id WHERE fields.instrument_id = 2 GROUP BY field_id) AS xy WHERE DATE(t)>'2011-02-08' AND DATE(t)<'" + to + "' GROUP BY date_trunc('" + value + "',t) ORDER BY date_trunc('" + value +"',t);")
      #if you use alias in the resultant data, you can use element.alias to invoke the result value.(ej sample.first.date and sample.first.value ) dont care if the attribute its in the model.
      @data = sample.map{|x| {:x=>Time.parse(DateTime.parse(x.date).to_s).to_i, :y=>x.value.to_f }}.to_json
      return unless sample.size < 50
    end
  end
end
