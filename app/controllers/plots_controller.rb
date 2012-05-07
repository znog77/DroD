class PlotsController < ApplicationController
  def index
  end
  def sqm
    from, to, id = Date.parse(params[:sqm][:from].to_s,"%d-%m-%Y"), Date.parse(params[:sqm][:to].to_s,"%d-%m-%Y"),params[:sqm][:Instrument]
    if from <= to
      if (@instrument = Instrument.find_by_id(id))
        scope = @instrument.timeWindow(from,to) # => de aca sacamos la ventana de tiempo en la q deberiamos tomar los datos.
        a1 = @instrument.fields.includes(:surveys).where(["surveys.value_time BETWEEN ? AND  ?",from,to])
        a2 = @instrument.fields.includes(:surveys).where(["field_id IN (?) AND surveys.type != ?",a1.map(&:id),"ValueTime"])
        result = (a1 + a2).group_by(&:id).values.map{|f1,f2| {f1.surveys.map{|ff| ff.value.strftime(scope)}.first => f2.surveys.map{|ff| ff.value}}}
        unless result.empty?
          data = result.inject{|memo, el| memo.merge( el ){|k, old_v, new_v| old_v + new_v}}
          #binding.pry
          @data=data.keys.map{ |k| {:x => k, :y => data[k].reduce(:+)/data[k].size} }.to_json # => hacemos el promedio por cada key
        else
          render :text => "no data available"
        end
      end
    else
      render :text => "worng from and to given"
    end
  end
end
