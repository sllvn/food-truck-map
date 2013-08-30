class MapController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @time_durations = (1..6).to_a.map do |x|
      ["Next #{pluralize(x, 'hour')}", "hours_#{x}"]
    end
  end
end
