task :parse_timetable =>:environment do
  
  require 'timetable_parser'
  VIC_TIMETABLE_URL = "http://www.victoria.ac.nz/timetables/2011%20Academic%20Timetable%20at%2020110420.html"
  TimetableParser.parse(VIC_TIMETABLE_URL)
end