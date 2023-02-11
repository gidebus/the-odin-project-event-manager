# frozen_string_literal: true

require_relative '../lib/phone_parser'

describe PhoneParser do
  let(:parser) { PhoneParser.new }
  
  context '#parse' do
    it 'removes area code if it starts with 1 and is 11 characters long' do
      phone_number = '12345678900'
      expect(parser.parse(phone_number)).to eq('2345678900')
    end

    it 'returns a valid number unparsed' do
      phone_number = '1234567890'
      expect(parser.parse(phone_number)).to eq(phone_number)
    end

    it 'returns nil if number is 11 characters and does not start with 1' do
      phone_number = '22345678900'
      expect(parser.parse(phone_number)).to eq(nil)
    end

    it 'returns nil if number is greater than 11 characters' do
      phone_number = '13322345678900'
      expect(parser.parse(phone_number)).to eq(nil)
    end
  end
end