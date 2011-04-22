require 'nokogiri'
require 'open-uri'

class TimetableParser
  
  SCHEMA = {
            :course => {
                :course=>   'td[1]//text()',
                :code=>     'td[2]//text()'
            },
            :stream => {
              :crn=>      'td[3]//text()'
            },
            :event => {
              :type=>     'td[4]//text()',
              :dates=>    'td[5]//text()',
              :days=>     'td[6]//text()',
              :start=>    'td[7]//text()',
              :finish=>   'td[8]//text()',
              :room=>     'td[9]//text()'
            }
           }
  
  class << self
    def parse(url = "")
      puts "Parsing Timetable...\n"
  
      f = File.open("lib/timetables/victoria/small_20110420.html")
      doc = Nokogiri::HTML(f)
  
      rows = doc.xpath('//tr')
      
      #An array of all the courses
      courses = []
      
      #For every row in the table
      rows.collect do |row|
        
        #A hash of each course's attributes (relates to models)
        attributes = {}
        
        #Use the schema on the row to get contents of a course attribute
        SCHEMA.each do |attribute, children|
          
          attribute = attribute.to_sym
          
          #Keep track of the attribute's attributes!
          child_hash = {}
        
          children.each do |child, xpath|
            child = child.to_sym
            text = row.at_xpath(xpath).to_s.strip
          
            #Create or update the hash
            child_hash.update({child => text})
          end
          
          attributes.update({attribute => child_hash})
        end
        courses << attributes
      end
      
      
      
      courses.each do |course|
        begin
          #If the course doesn't have a CRN we don't care about it
          if course[:stream][:crn].to_i.eql? 0
            next
          end
          #Make a course from the attributes
          make_course(course)
        rescue ActiveRecord::RecordInvalid, NoMethodError => error
          p error
        end
      end
    
      f.close
    end
  
    def make_course(course_attrs)
      
      course = Course.find_or_create_by_course_and_code(
                  :course => course_attrs[:course][:course], 
                  :code => course_attrs[:course][:code])
      
      stream = Stream.find_or_create_by_crn(course_attrs[:stream][:crn].to_i)
      stream.update_attributes(:course => course)
      
      stream.events << make_events( stream, course_attrs[:event])
      
      course.streams << stream
      
      course
    end
                  
    def make_events(stream, event_details)
      events = []
      
      days = event_details[:days].split(//)
      
      date = get_date(event_details[:dates])
      
      days.each do |d|
        date = add_day_of_week(date, d)
        
        start_time = event_details[:start].split(/:/)
        starts_at = date + start_time[0].to_i.hours + start_time[1].to_i.minutes
        
        end_time = event_details[:finish].split(/:/)
        ends_at = date + end_time[0].to_i.hours + end_time[1].to_i.minutes
        
        event = Event.find_or_create_by_stream_id_and_starts_at(:stream=>stream, :starts_at => starts_at)
            
        event.update_attributes(:ends_at => ends_at, :room => event_details[:room])
            
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