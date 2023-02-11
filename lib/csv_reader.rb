# frozen_string_literal: true

require 'csv'

class CsvReader
  def read(filename)
    contents ||= CSV.open(
      filename,
      headers: true,
      header_converters: :symbol
    )
  end
end