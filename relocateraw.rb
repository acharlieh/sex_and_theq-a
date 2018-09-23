require 'yaml'

Dir.mkdir('raw') unless Dir.exist?('raw')

Dir['articles/*.yml'].each_with_index do |file,idx| 
  data = YAML.load_file(file)
  sha = data[:sha]
  body = data.delete(:body)
  unless body
    puts "#{idx}. #{sha} No Body"
    next
  end

  puts "#{idx}. #{sha} Processing..."
  File.open("raw/#{sha}.htm","w") {|f|  f.write( body ) }
  File.open(file,'w') {|f|  f.write( data.to_yaml ) }
end
