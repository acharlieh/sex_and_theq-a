require 'yaml'
require 'nokogiri'

Dir['articles/*.yml'].each_with_index do |file,idx| 
  data = YAML.load_file(file)
  sha = data[:sha]
  uri = data[:uri]
  rawfile = "raw/#{sha}.htm"
  article =  File.open(rawfile) { |f| Nokogiri::HTML(f) }

  puts "#{idx}. #{sha} ReProcessing #{uri}..."

  intro = article.xpath("//div[@itemprop='articleBody']/p[1]").first
  intro = intro.text() if intro
  data[:intro] = intro if intro

  questions = article.xpath("//div[@itemprop='articleBody']/p[not(position()=1)]//strong").collect do |n|
    if n.previous() && n.previous().name() == 'strong'
        nil
    else
        text = n.text()
        node = n.next()
        while node && node.name() == 'strong'
          text = text + node.text()
          node = node.next()
        end
        text
    end
  end.delete_if(&:nil?).collect(&:strip).delete_if(&:empty?)
  data[:questions] = questions if questions

  File.open(file,'w') {|f|  f.write( data.to_yaml ) }
end
