class MapController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @time_durations = (1..6).to_a.map do |x|
      ["Next #{pluralize(x, 'hour')}", "hours_#{x}"]
    end
  end

  def checkin
    @location = current_food_business.location || Location.new
    @location.latitude, @location.longitude = params[:check_in][:address].split(',').map(&:strip)
    # TODO: create TimeRange object to handle duration, etc.
    duration_in_hours = params[:check_in][:duration].match('hours_(\d)')[1].to_i
    @location.start_time = Time.now
    @location.end_time = Time.now + duration_in_hours.hours

    current_food_business.location = @location

    if @location.save and current_food_business.save
      redirect_to root_path, notice: "Thanks for checking in!"
    else
      redirect_to root_path, error: "There was an error checking in."
    end
  end
end
