# frozen_string_literal: true

class PhoneParser
  def parse(number)
    if number.length == 10
        phone_number = number
    elsif number.length == 11 && number[0] == '1'
      phone_number = number[1..11]
    else
      phone_number = nil
    end
  end
end
