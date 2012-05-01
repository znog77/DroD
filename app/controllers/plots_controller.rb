class PlotsController < ApplicationController
  def index
  end
  def sqm
    #binding.pry
    #@data = Instrument.first.surveys.order(:field_id).group_by(&:field_id).values.map{ |x,y| {:x=> x.value.to_i, :y => y.value}}.to_json
    @data = Instrument.first.surveys.where('field_id IN (SELECT field_id FROM surveys WHERE type=\'ValueTime\' AND DATE(value_time)>"'+params[:sqm][:from].to_s+' AND DATE(value_time)<'+params[:sqm][:to].to_s+'")').order(:field_id).group_by(&:field_id).values.map{ |x,y| {:x=> x.value.to_i, :y => y.value}}.to_json
  end
end
