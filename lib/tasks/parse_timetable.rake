task :parse_timetable =>:environment do
  
  require 'timetable_parser'
  
  TimetableParser.parse("lib/timetables/victoria/20110420.html")
end