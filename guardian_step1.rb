require 'nokogiri'
require 'open-uri'
require 'set'
require 'yaml'

pages = Set['https://www.theguardian.com/lifeandstyle/series/qa']
pagesvisited = Set[]

articles = Set[]

loop do
  batch = pages - pagesvisited
  break if batch.empty?

  batch.each do |uri|
    puts "Reading: #{uri} ... "
    doc = Nokogiri::HTML(open(uri))
    pages = pages + doc.xpath('//a[@data-page]/@href').collect(&:value)
    articles = articles + doc.xpath("//section[@data-id]//a[@data-link-name='article']/@href").collect(&:value) 
    pagesvisited.add(uri)
  end
end

File.open('guardian_articles.yml','w') {|f|  f.write( { articles: articles.to_a }.to_yaml ) }
File.open('guardian_pages.yml','w') {|f|  f.write( { pages: pages.to_a }.to_yaml ) }
