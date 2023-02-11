# frozen_string_literal: true

require_relative './csv_reader'
require_relative './zipcode_parser'
require_relative './legislators_api_getter'
require_relative './writer'
require_relative './phone_parser'
require_relative './registration_analyzer'

require 'google/apis/civicinfo_v2'
require 'erb'

puts 'EventManager initialized.'

class EventManager

  def initialize(
    reader = CsvReader.new,
    phone_parser = PhoneParser.new,
    zipcode_parser = ZipcodeParser.new,
    legislators_getter = LegislatorsApiGetter.new,
    analyzer = RegistrationAnalyzer.new,
    writer = Writer.new
  )
    @reader = reader
    @phone_parser = phone_parser
    @zipcode_parser = zipcode_parser
    @legislators_getter = legislators_getter
    @analyzer = analyzer
    @writer = writer
  end

  def load_csv_data
    @reader.read('event_attendees.csv')
  end

  def generate_thank_you_letter
    load_csv_data
    template_letter = File.read('form_letter.erb')
    erb_template = ERB.new(template_letter)

    load_csv_data.each do |row|
      id = row[0]
      name = row[:first_name]
      phone = @phone_parser.parse(row[:homephone])
      zipcode = @zipcode_parser.parse(row[:zipcode])    
      legislators = @legislators_getter.fetch_by_zipcode(zipcode)
      form_letter = erb_template.result(binding)
      @writer.make_thank_you_letter(id, form_letter)
    end

  end

  def highest_registration_day_and_hour
    load_csv_data
    registration_dates = []

    load_csv_data.each do |row|
      registration_time = row[:regdate]
      registration_dates << registration_time
    end

    dates = @analyzer.parse_date(registration_dates)
    @analyzer.most_active_day(dates)
    @analyzer.most_active_hour(dates)
  end
end
