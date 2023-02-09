# frozen_string_literal: true

class PhoneParser
  def clean_phone_number(number)
    if number.length == 10
        phone_number = number
    elsif number.length == 11 && number[0] == '1'
      phone_number = number[1..11]
    else
      phone_number = nil
    end
  end
end

# If the phone number is less than 10 digits, 
# assume that it is a bad number

# If the phone number is 10 digits,
#  assume that it is good

# If the phone number is 11 digits 
# and the first number is 1, trim the 1 
# and use the remaining 10 digits

# If the phone number is 11 digits 
# and the first number is not 1, 
# then it is a bad number

# If the phone number is more than 11 digits, 
# assume that it is a bad number


