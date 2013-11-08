class ScheduleEntrySerializer < ActiveModel::Serializer
  attributes :address, :latitude, :longitude, :hours

  def hours
    # TODO: fix me!
    #"#{object.start_time.strftime('%I:%M %P')} - #{object.end_time.strftime('%I:%M %P')}"
    ""
  end
end
