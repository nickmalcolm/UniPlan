Factory.define :course do |c|
  c.course "ABCD"
  c.code "1234"
end

Factory.define :stream do |s|
  s.course { Factory(:course) }
  s.sequence(:crn) {|n| n }
end

Factory.define :event do |e|
  e.starts_at { DateTime.parse("15:10 1 Jan 2011") }
  e.ends_at { DateTime.parse("16:00 1 Jan 2011") }
  e.stream { Factory(:stream) }
end