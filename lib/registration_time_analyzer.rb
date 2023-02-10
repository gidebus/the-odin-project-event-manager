# frozen_string_literal: true

class RegistrationTimeAnalyzer

  def parse_date(arr)
    arr.map { |date| date_time = DateTime.strptime(date,'%m/%d/%y %H:%M') }
  end

  def most_active_day(arr)
    days = arr.map { |date| date.strftime('%A') }
    day = days.max_by { |day| days.count(day) }
    puts day
  end

  def most_active_hour(arr)
    hours = arr.reduce(0) do |sum, date| 
      hour = date.hour
      minute = (date.minute).to_f / 60
      sum += (hour + minute).round(0) 
    end
    average = hours / arr.length
    puts DateTime.strptime(average.to_s, '%H').strftime('%r')
  end
end
