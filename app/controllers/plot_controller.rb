class PlotController < ApplicationController
  def index
  end

  def sqm
    from, to, id = Date.parse(params[:sqm][:from].to_s,"%d-%m-%Y"), Date.parse(params[:sqm][:to].to_s,"%d-%m-%Y"),params[:sqm][:Instrument]
    if from <= to
      if (@instrument = Instrument.find_by_id(id))
        if params[:sqm][:noautoscope]=="1" then
          scope="%Y%m%d%H%M"
        else
          scope = @instrument.timeWindow(from,to) # => de aca sacamos la ventana de tiempo en la q deberiamos tomar los datos.
        end

        if params[:sqm][:lunar]=="1" then
          #filter by moon phases
          phases = new_moon_calendar(DateTime.parse(from.to_s),DateTime.parse(to.to_s))
          q=[]
          phases.each do |p|
            q<<"surveys.value_time BETWEEN '"+(p-7.days).to_s+"' AND '"+(p+7.days).to_s+"'"
          end
          query=q.join(" OR ")
          if params[:sqm][:hours]=="1" then
            query="EXTRACT('hour' FROM surveys.value_time) NOT BETWEEN 6 AND 22 AND ("+query+")"
            puts query
          end
        else
          query=["surveys.value_time BETWEEN ? AND  ?",from,to]
        end

        a1 = @instrument.fields.includes(:surveys).where(query).order(:value_time)
        #binding.pry
        a2 = @instrument.fields.includes(:surveys).where(["field_id IN (?) AND surveys.type != ?",a1.map(&:id),"ValueTime"])
        result = (a1 + a2).group_by(&:id).values.map{|f1,f2| {f1.surveys.map{|ff| ff.value.strftime(scope)}.first => f2.surveys.map{|ff| ff.value}}}
        unless result.empty?
          data = result.inject{|memo, el| memo.merge( el ){|k, old_v, new_v| old_v + new_v}}
          @data=data.keys.map{ |k| {:x => Time.parse(k,scope).to_i, :y => data[k].reduce(:+)/data[k].size} }.to_json # => hacemos el promedio por cada key
          #binding.pry
        else
          render :text => "no data available"
        end
      end
    else
      render :text => "wrong from and to given"
    end
  end
end
