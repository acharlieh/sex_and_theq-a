require 'yaml'

asked = Hash.new(0)
unasked = Hash.new(0)

Dir['articles/*.yml'].each_with_index do |file,idx| 
  data = YAML.load_file(file)
  sha = data[:sha]
  uri = data[:uri]
  gender = data[:gender]

  puts "#{idx}. #{sha} Processing..."

  idx = data[:questions].index() { |x| x.include? 'sex' }

  if idx
    asked[gender] += 1
  else
    unasked[gender] += 1
  end

end

puts "asked: #{asked.inspect}"

puts "unasked: #{unasked.inspect}"
