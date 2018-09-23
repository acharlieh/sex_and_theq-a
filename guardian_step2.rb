require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'digest'

Dir.mkdir('articles') unless Dir.exist?('articles')
Dir.mkdir('raw') unless Dir.exist?('raw')

YAML.load_file('guardian_articles.yml')[:articles].each_with_index do |uri,idx|
  
  sha = Digest::SHA256.hexdigest uri
  file = "articles/#{sha}.yml"
  rawfile = "raw/#{sha}.htm"
  if File.exists?(file) and File.exists?(rawfile)
    puts "#{idx}. #{sha} Skipping #{uri}. "
    next
  end

  puts "#{idx}. #{sha} Processing #{uri}..."

  article = Nokogiri::HTML(open(uri))
  intro = article.xpath("//div[@itemprop='articleBody']/p[1]").first
  intro = intro.text() if intro
  questions = article.xpath('//strong/text()').collect(&:text)

  data = {
    sha: sha,
    uri: uri,
    intro: intro,
    questions: questions
  }

  File.open(file,'w') {|f|  f.write( data.to_yaml ) }
  File.open(rawfile,'w') {|f| f.write( article.to_html ) }
end
