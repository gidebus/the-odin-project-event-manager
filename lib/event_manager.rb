# frozen_string_literal: true

require_relative './csv_reader.rb'
require_relative './zipcode_parser.rb'
require_relative './legislators_api_getter.rb'
require_relative './writer.rb'
require_relative './phone_parser.rb'
require_relative './registration_time_analyzer.rb'

require 'google/apis/civicinfo_v2'
require 'erb'

puts 'EventManager initialized.'

contents = CsvReader.new.read('event_attendees.csv')
template_letter = File.read('form_letter.erb')
erb_template = ERB.new(template_letter)
registration_dates = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = PhoneParser.new.parse(row[:homephone])
  zipcode = ZipcodeParser.new.parse(row[:zipcode])

  registration_time = row[:regdate]
  registration_dates << registration_time
  
  legislators = LegislatorsApiGetter.new.fetch_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)
  Writer.new.make_thank_you_letter(id, form_letter)
end


analyzer = RegistrationTimeAnalyzer.new
dates = analyzer.parse_date(registration_dates)
analyzer.most_active_day(dates)
analyzer.most_active_hour(dates)
