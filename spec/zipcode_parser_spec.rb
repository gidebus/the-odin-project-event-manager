# frozen_string_literal: true

require_relative '../lib/zipcode_parser'

describe ZipcodeParser do
  let(:parser) { ZipcodeParser.new }
  describe '#parse' do
    it 'returns 0s if zipcode is nil' do
      expect(parser.parse(nil)).to eq('00000')
    end 

    it 'prefixes missing character with 0' do
      three_digit_zipcode = '123'
      expect(parser.parse(three_digit_zipcode)).to eq('00123')
      one_digit_zipcode = '1'
      expect(parser.parse(one_digit_zipcode)).to eq('00001')
    end

    it 'removes last digits until zipcode is 5 characters in length' do
      zipcode = '12345678'
      expect(parser.parse(zipcode)).to eq('12345')
    end
  end
end