# frozen_string_literal: true

class Writer
  def make_thank_you_letter(id, form_letter)
    Dir.mkdir('output') unless Dir.exist?('output')
  
    filename = "output/thanks_#{id}.html"
  
    File.open(filename, 'w') do |file|
      file.puts form_letter
    end
  end
end