# frozen_string_literal: true

require_relative '../lib/registration_analyzer'
require 'date'

describe RegistrationAnalyzer do
  let(:analyzer) { RegistrationAnalyzer.new }
  let(:dates) { ['11/12/08 1:00', '11/13/08 2:00', '11/14/08 3:00'] }
  
  describe '#parse_date' do
    it 'parses strings into DateTime objects in the correct format' do
      expected = DateTime.strptime('11/12/08 1:00','%m/%d/%y %H:%M')
      expect(analyzer.parse_date(dates).first).to eq(expected)
    end
  end

  describe '#most_active_day' do
    context 'returns most active day' do
      let(:parsed_dates) { analyzer.parse_date(dates) }
      specify { expect { analyzer.most_active_day(parsed_dates) }.to output(/Wednesday/).to_stdout }
    end
  end

  describe '#most_active_hour' do
    context 'returns most active hour' do
      let(:parsed_dates) { analyzer.parse_date(dates) }
      specify { expect { analyzer.most_active_hour(parsed_dates) }.to output(/02:00:00 AM/).to_stdout }
    end
  end
end