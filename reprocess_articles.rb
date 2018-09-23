require 'yaml'

Dir['articles/*.yml'].each_with_index do |file,idx| 
  data = YAML.load_file(file)
  sha = data[:sha]
  uri = data[:uri]

  puts "#{idx}. #{sha} Processing..."

  intro = data[:intro]
  data[:gender] = case 
  when intro.nil?
    'unknown'
  when intro.match(/(?i)\b(?:she|her)\b/)
    'female'
  when intro.match(/(?i)\b(?:he|his)\b/)
    'male'
  else
    'unknown'
  end

  File.open(file,'w') {|f|  f.write( data.to_yaml ) }
end
