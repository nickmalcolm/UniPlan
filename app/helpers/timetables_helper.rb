module TimetablesHelper
  
  def days
    %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
  end

  def num_to_12_hr(num)
    if num < 12
      "#{num}am"
    elsif num == 12
      "#{num}pm"
    else
      num -= 12
      "#{num}pm"
    end
  end
  
  def event_at(timetable, hour, day)
    puts "events at #{hour} on #{day}"
    events = timetable.events.which_start_at(hour).on_day(day).all
    unless events.empty?
      events.first.stream.course.name
    else
      ""
    end
  end

end
