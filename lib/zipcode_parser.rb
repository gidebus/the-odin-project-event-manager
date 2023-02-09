# frozen_string_literal: true

class ZipcodeParser
  def parse(zipcode)
    zipcode.to_s.rjust(5, "0")[0..4]
  end
end