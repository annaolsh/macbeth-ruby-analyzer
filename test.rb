require 'nokogiri'
require 'open-uri'
require 'pry'

#helper functions
# write a function given input line will output number of words
def count_words(string)
  #/\p{Pd}/ for dash
  string.split(/\s/).count
end

def find_or_create_item(hash,item,value)
  if hash.key?(item)
    return hash[item]
  else
    return hash[item] = value
  end
end

#Fetch and parse XML document
doc = Nokogiri::XML(open('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'))
#init hash
characters = {}
#Search for nodes by speech
doc.xpath('//SPEECH').each do |speech|
  speaker_name = speech.xpath('SPEAKER').text.downcase
  if speaker_name != 'all'
    character = find_or_create_item(characters,speaker_name,{'word_count' => 0})
    num_words_speech = 0
    speech.xpath('LINE').each do|line|
      num_words_speech += count_words(line.text)
    end
    character['word_count'] += num_words_speech
  end
end

characters.each do |character|
  puts "#{character[0]} spoke #{character[1]['word_count']} times"
end
