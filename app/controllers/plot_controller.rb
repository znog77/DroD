class PlotController < ApplicationController
  def sqm
    @data = Instrument.first.surveys.order(:field_id).group_by(&:field_id).values.map{ |x,y| {:x=> x.value.to_i, :y => y.value}}.to_json
  end
end
