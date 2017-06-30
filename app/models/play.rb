class Play < ApplicationRecord
  attr_reader :doc, :characters

  def self.count_words(string)
    string.split(/\s/).count
  end

  def self.find_or_create_item(hash,item,value)
    if hash.key?(item)
      return hash[item]
    else
      return hash[item] = value
    end
  end

  def fetch_xml
    @doc = Nokogiri::XML(open("#{self.url}"))
  end

  def get_character_hash
    @characters = {}
    self.doc.xpath('//SPEECH').each do |speech|
      speaker_name = speech.xpath('SPEAKER').text.downcase
      if speaker_name != 'all'
        character = Play.find_or_create_item(characters,speaker_name,{'word_count' => 0})
        num_words_speech = 0
        speech.xpath('LINE').each do|line|
          num_words_speech += Play.count_words(line.text)
        end
        character['word_count'] += num_words_speech
      end
    end
    @characters
  end

  def get_chart_data
    labels = []
    word_count = []
    self.characters.each do|character|
      labels.push(character[0])
      word_count.push(character[1]['word_count'])
    end
    {labels: labels , word_count: word_count}
  end
end
