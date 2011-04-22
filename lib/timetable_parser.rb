require 'nokogiri'
require 'open-uri'

class TimetableParser
  
  class << self
    def parse(url = "")
      puts "Parsing Timetable...\n"
  
      f = File.open("lib/timetables/victoria/small_20110420.html")
      doc = Nokogiri::HTML(f)
  
      rows = doc.xpath('//tr')
  
      details = rows.collect do |row|
        detail = {}
        [
          [:course,   'td[1]//text()'],
          [:code,     'td[2]//text()'],
          [:crn,      'td[3]//text()'],
          [:type,     'td[4]//text()'],
          [:dates,    'td[5]//text()'],
          [:days,     'td[6]//text()'],
          [:start,    'td[7]//text()'],
          [:finish,   'td[8]//text()'],
          [:room,     'td[9]//text()'],
        ].collect do |name, xpath|
          detail[name] = row.at_xpath(xpath).to_s.strip
        end
        detail
      end
  
      # y details[6][:crn]
      #       y details[6][:crn].to_i
      details.each do |d|
        begin
          if d[:crn].to_i.eql? 0
            next
          end
          make_course(d)
        rescue ActiveRecord::RecordInvalid, NoMethodError => error
          p error
        end
      end
    
      f.close
    end
  
    def make_course(detail)
      
      course = Course.find_or_create_by_course_and_code(:course => detail[:course], :code => detail[:code])
      
      stream = Stream.find_or_create_by_crn(detail[:crn].to_i)
      stream.update_attributes(:course => course)
      
      stream.events << make_events( stream, detail[:type], detail[:dates],
                                    detail[:days], detail[:start], detail[:finish], 
                                    detail[:room])
      
      course.streams << stream
      
      course
    end
                  
    def make_events(stream, type, dates, day_initials, start, finish, room)
      events = []
      
      days = day_initials.split(//)
      
      date = get_date(dates)
      
      days.each do |d|
        date = add_day_of_week(date, d)
        
        start_time = start.split(/:/)
        starts_at = date + start_time[0].to_i.hours + start_time[1].to_i.minutes
        
        end_time = finish.split(/:/)
        ends_at = date + end_time[0].to_i.hours + end_time[1].to_i.minutes
        
        event = Event.find_or_create_by_stream_id_and_starts_at(:stream=>stream, :starts_at => starts_at)
            
        event.update_attributes(:ends_at => DateTime.now, :room => room)
            
        events << event
      end
        
      events
    end
    
    TRIMESTER_ONE_2011 = DateTime.parse("02/28/2011")
    TRIMESTER_TWO_2011 = DateTime.parse("07/11/2011")
    
    def get_date(dates)
      spl = dates.split(/ /)
      
      date = nil
      
      if spl[0].eql?"Trimester"
        if spl[1].eql?"1"
          date = TRIMESTER_ONE_2011
        elsif spl[1].eql?"2"
          date = TRIMESTER_TWO_2011
        end
      end
      
      date
    end
    
    def add_day_of_week(date, day_initial)
      case day_initial.upcase
      when "T"
        date = date + 1.day
      when "W"
        date = date + 2.days
      when "R"
        date = date + 3.days
      when "F"
        date = date + 4.days
      when "S"
        date = date + 5.days
      when "U"
        date = date + 6.days
      end
      
      date
    end
    
  end
  
end