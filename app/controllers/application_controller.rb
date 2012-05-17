class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  def new_moon_calendar(start_date, end_date)
    require 'astro/moon'
    nmc=[]
    begin
      new_moon=Astro::Moon.phasehunt(start_date).moon_end
      start_date=new_moon.next_day
      nmc << new_moon
    end until new_moon > end_date
    return nmc
  end

end
